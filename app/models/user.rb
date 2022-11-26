class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  GENDERS = ['Male', 'Female', 'Other']

  validates :email, :first_name, :last_name, :phone, presence: true
  validates :email, :phone, uniqueness: true

  has_many :weights, dependent: :destroy
  has_one_attached :photo

  @imc = 0

  def sort_weight
    weights_all.sort
  end

  def progress_from_min
    return "ainda sem info" if weight_min_with_date.nil?
    last_weight = weights_all.last

    calc = weight_min_with_date[0] - last_weight

    if calc.positive?
      "You have reduced #{calc} kg since #{created_at.strftime('%d/%b/%Y')}"
    else
      "You have gained MIN #{calc.abs} kg since #{weight_min_with_date[1].strftime('%d/%b/%Y')}"
    end
  end

  def max_weight
    (40 * ((height)/100)**2)
  end

  def min_weight
    (18.5 * ((height)/100)**2)
  end

  def percentage
    100 / (max_weight - min_weight) * (weights.last&.value - min_weight)
  end

  def progress_from_begin
    last_weight = weights_all.last
    first_weight = weights_all.first
    return "ainda sem info" if first_weight.nil? || last_weight.nil?
    calc = first_weight - last_weight

    if calc.positive?
      "You have reduced #{calc} kg since #{Weight.first.created_at.strftime('%d/%b/%Y')}"
    else
      "You have gained BEGIN #{calc.abs} kg since #{Weight.first.created_at.strftime('%d/%b/%Y')}"
    end
  end

  def imc_calc
    last_weight = weights_all.last
    if height
      imc = last_weight / ((height**2) / 10_000)
      @imc = imc.round(2)
    else
      @imc = 0
    end
  end

  def imc_message
    if @imc < 16
      "Severe thinness"
    elsif @imc <= 17
      "Moderate thinness"
    elsif @imc <= 18.49
      "Mild thinness"
    elsif @imc <= 24.99
      "Normal Weight"
    elsif @imc <= 29.99
      "Overweight"
    elsif @imc <= 34.99
      "Obesity class I"
    elsif @imc <= 39.99
      "Obesity class II"
    else
      "Obesity class III"
    end
  end

  def ideal_weight
    return 0 if height.nil?
    if self == "male"
      ideal_weight = 22 * ((height / 100)**2)
      ideal_weight.round(2)
    else
      ideal_weight = 21 * ((height / 100)**2)
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
