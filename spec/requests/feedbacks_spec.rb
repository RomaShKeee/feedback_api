# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feedbacks', type: :request do
  describe 'POST /feedbacks' do
    context 'success' do
      it 'works! (now write some real specs)' do
        params = { feedback: { company_token: '1234', priority: 'minor' },
                   state: { device: 'iPhone 5', os: 'iOS', memory: '1024', storage: '20480' } }
        post feedbacks_path, params: params
        expect(response).to have_http_status(201)
        expect(json_body[:number]).to eq(1)
      end
    end
  end

  describe 'GET /feedbacks/:number' do
    context 'success' do
      let(:feedback) { Feedback.create(company_token: '1234', number: 1, priority: 'minor') }
      it 'get all feedbacks by company' do
        headers = { 'X-COMPANY-TOKEN': '1234' }
        get feedback_path(feedback.number), headers: headers
        expect(response).to have_http_status(200)
        expect(json_body.keys).to eq(%w[id number priority])
      end
    end
  end

  describe 'GET /feedbacks/count' do
    context 'success' do
      before do
        Feedback.create(company_token: '1234', number: 1, priority: 'minor')
      end
      it 'get all feedbacks by company' do
        headers = { 'X-COMPANY-TOKEN': '1234' }
        get count_feedbacks_path, headers: headers
        expect(response).to have_http_status(200)
        expect(json_body['count']).to eq(1)
      end
    end
  end

  describe 'GET /feedbacks' do
    context 'success' do
      before do
        Feedback.create(company_token: '1234', number: 1, priority: 'minor')
      end
      it 'get all feedbacks by company' do
        headers = { 'X-COMPANY-TOKEN': '1234' }
        get feedbacks_path, headers: headers
        expect(response).to have_http_status(200)
        expect(json_body.last.keys).to eq(%w[id number priority])
      end
    end
  end
end
