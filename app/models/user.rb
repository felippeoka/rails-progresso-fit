class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, :first_name, :last_name, :phone, presence: true
  validates :email, :phone, uniqueness: true

  has_many :weights, dependent: :destroy
  has_one_attached :photo

  @imc = 0

  def sort_weight
    weights_all.sort
  end

  def progress_from_min
    last_weight = weights_all.last
    calc = weight_min_with_date[0] - last_weight

    if calc.positive?
      "You have reduced #{calc} kg since #{created_at.strftime("%d/%b/%Y")}"
    else
      "You have gained MIN #{calc.abs} kg since #{weight_min_with_date[1].strftime("%d/%b/%Y")}"
    end
  end

  def progress_from_begin
    last_weight = weights_all.last
    first_weight = weights_all.first
    calc = first_weight - last_weight

    if calc.positive?
      "You have reduced #{calc} kg since #{Weight.first.created_at.strftime("%d/%b/%Y")}"
    else
      "You have gained BEGIN #{calc.abs} kg since #{Weight.first.created_at.strftime("%d/%b/%Y")}"
    end
  end

  def imc_calc
    last_weight = weights_all.last
    imc = last_weight / ((height ** 2)/10000)
    @imc = imc.round(2)
  end

  def imc_message
    if @imc<16
      "Severe thinness"
    elsif @imc<=17
      "Moderate thinness"
      elsif @imc<=18.49
        "Mild thinness"
          elsif @imc<=24.99
            "Normal Weight"
            elsif @imc<=29.99
              "Overweight"
              elsif @imc<=34.99
                "Obesity class I"
                elsif @imc<=39.99
                  "Obesity class II"
                  else
                    "Obesity class III"
    end
  end

  def ideal_weight
     if self == "male"
      ideal_weight = 22 * ((height)/100)**2
      ideal_weight.round(2)
    else
      ideal_weight = 21 * ((height)/100)**2
      ideal_weight.round(2)
    end
  end

  private

  def weight_min_with_date
    weights_dates = weights.pluck(:value, :created_at).sort
    weights_dates[0]
  end

  def weights_all
    weights.pluck(:value)
  end

end
