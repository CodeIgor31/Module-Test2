# frozen_string_literal: true

# array controller
class ArraysController < ApplicationController
  before_action :set_original_arr, only: :result
  before_action :validate_string, only: :result
  before_action :validate_last, only: :result
  before_action :validate_minuses_and_points, only: :result
  before_action :validate_space, only: :result
  before_action :proizv, only: :result
  before_action :validate_all, only: :result

  def input; end

  def result
    @fixed = fix_array(@orig_array.split.map(&:to_f))
    @sum = proizv
  end

  private

  def set_original_arr
    @orig_array = params[:input_array]
  end

  def validate_last
    flash[:notice] = 'Последний символ должен быть числом' unless @orig_array.match(/\D$/).nil?
  end

  def validate_space
    flash[:info] = 'После числа должен быть пробел' if @orig_array.match?(/\d+\s+/).nil?
  end

  def validate_string
    flash[:alert] = "Исправьте #{@orig_array.match(/\D*[^\s\d\-.]/)}" unless
    @orig_array.match(/\D*[^\s\d\-.]/).nil?
  end

  def validate_minuses_and_points
    return if (@orig_array.match(/(-\D+|\D+\.)/) || @orig_array.match(/\.\D+/)).nil?

    flash[:warning] = 'После - и . должно быть число, перед точкой тоже'
  end

  def proizv
    p = 1
    arr = @orig_array.split.map(&:to_f)
    arr.each do |elem|
      p *= elem if (elem % 5).zero? && (elem != 0)
    end
    flash[:error] = 'Нет чисел, кратных 5' if p == 1
    p
  end

  def validate_all
    redirect_to home_path unless flash.empty?
  end

  def fix_array(arr)
    index, flag = find_index(arr)
    if flag == true
      arr[index + 1] = proizv
    else
      arr[index] = proizv
    end
    arr.join(' | ')
  end

  def find_index(arr)
    flag = false
    index = 0
    arr.each_cons(2) do |curr_el, next_el|
      if next_el < curr_el
        flag = true
        break
      end
      index += 1
    end
    [index, flag]
  end
end
