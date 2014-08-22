module Vaporbox

  describe Session do
    describe "#get" do
      it "captures the session id" do
        s = Session.new
        json = s.get("get_email_address")
        expect(s.session_id).to_not be_nil
      end

      it "remembers the current email address for subsequent calls" do
        s = Session.new
        a = s.get("get_email_address")
        b = s.get("get_email_address")
        expect(a["email_addr"]).to eql(b["email_addr"])
      end

    end
  end

end
