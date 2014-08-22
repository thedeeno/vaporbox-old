module Vaporbox

  describe Client do
    describe "#get_email_address" do
      it "saves the session id" do
        c = Client.new
        json = c.get_email_address
      end

      it "remembers the current email address for subsequent calls" do
        c = Client.new
        a = c.get("get_email_address")
        b = c.get("get_email_address")
        expect(a["email_addr"]).to eql(b["email_addr"])
      end

    end
  end

end
