class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode payload, nil, 'none'
    end

    def decode(token)
      body = JWT.decode(token, nil, false)[0]
      #puts 'BODY & token ===>>>> '+ token.to_s + body.to_s
      #HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end