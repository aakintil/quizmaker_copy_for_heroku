require 'test_helper'

class QuestionTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => QuestionType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    QuestionType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    QuestionType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to question_type_url(assigns(:question_type))
  end

  def test_edit
    get :edit, :id => QuestionType.first
    assert_template 'edit'
  end

  def test_update_invalid
    QuestionType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => QuestionType.first
    assert_template 'edit'
  end

  def test_update_valid
    QuestionType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => QuestionType.first
    assert_redirected_to question_type_url(assigns(:question_type))
  end

  def test_destroy
    question_type = QuestionType.first
    delete :destroy, :id => question_type
    assert_redirected_to question_types_url
    assert !QuestionType.exists?(question_type.id)
  end
end
