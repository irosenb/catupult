require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
  it "should have a twilio client" do
    user = User.create(last_name: "Rosenberg", 
                           token: "Je5CDuGC9OT3AffSyJfSRd42ezPKT0Vh2CoJLOzctfxC7LrLTyKlEaFshCJyIaqU22D2atpYuXLiekPwkdqXDlECdgRlo_GULMgGZS0EumxrKbZFiOmnmAPChBPDZ5JP", 
                      first_name: "Isaac", 
                             uid: "8CTHBQVAqsZeZSDKLO313g",
                    phone_number: "(646)-544-9091")

    expect(user.twilio_client.class).to eql(Twilio::REST::Client)
  end

  it "should have a jawbone client" do
    
  end
end
