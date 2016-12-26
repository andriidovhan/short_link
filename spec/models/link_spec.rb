require 'spec_helper'
require 'rails_helper'


describe Link do
  context 'valid params' do
    let(:create_link) { Link.create!(origin: 'test-link.com', shorten: 'sdadTERWDASxdc') }

    it 'create link' do
      expect{ create_link }.to change{ Link.count }.by(1)
    end
  end

  context 'negative tests' do
    let(:origin_empty) { Link.create!(origin: '', shorten: 'sdnWESAas') }
    let(:origin_less_3) { Link.create!(origin: 't.a', shorten: 'sdnWESAas') }
    let(:shorten_empty) { Link.create!(origin: 'test-link.com', shorten: '') }
    let(:both_empty) { Link.create!(origin: '', shorten: '') }
    let(:create_correct_link) {Link.create!(origin: 'origin-unique.com', shorten: 'shorten-unique')}
    
    it 'empty origin param' do
      expect{ origin_empty }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Origin can\'t be blank, Origin is too short (minimum is 4 characters)')
    end

    it 'short origin param (< 4 character)' do
      expect{ origin_less_3 }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Origin is too short (minimum is 4 characters)')
    end

    it 'empty shorten param' do
      expect{ shorten_empty }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Shorten can\'t be blank')
    end

    it 'both params are empty' do
      expect{ both_empty }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Origin can\'t be blank, Origin is too short (minimum is 4 characters), Shorten can\'t be blank')
    end

    it 'create link and should not be created with the same origin param' do
      create_correct_link
      expect { Link.create!(origin: 'origin-unique.com', shorten: 'diff-shorten') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Origin has already been taken')
    end

    it 'create link and should not be created with the same shorten param' do
      create_correct_link
      expect { Link.create!(origin: 'diff-origin.com', shorten: 'shorten-unique') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Shorten has already been taken')
    end

    it 'should not be created the full same link' do
      create_correct_link
      expect{ Link.create!(origin: 'origin-unique.com', shorten: 'shorten-unique') }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Origin has already been taken, Shorten has already been taken')
    end
  end

  describe '.create' do
    before do
      Link.create!(origin: 'test-link-1', shorten: 'test-short-1')
    end

    it 'make sure' do
      expect((Link.find_by origin: 'test-link-1').shorten).to eql 'test-short-1'
    end
  end

  describe '.show' do
    before do
      Link.create!(origin: 'test-link-1', shorten: 'test-short-1')
    end

    it 'should be redirected' do
    end
  end
end
