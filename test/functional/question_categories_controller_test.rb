require 'test_helper'

class QuestionCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => QuestionCategory.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    QuestionCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    QuestionCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to question_category_url(assigns(:question_category))
  end

  def test_edit
    get :edit, :id => QuestionCategory.first
    assert_template 'edit'
  end

  def test_update_invalid
    QuestionCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => QuestionCategory.first
    assert_template 'edit'
  end

  def test_update_valid
    QuestionCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => QuestionCategory.first
    assert_redirected_to question_category_url(assigns(:question_category))
  end

  def test_destroy
    question_category = QuestionCategory.first
    delete :destroy, :id => question_category
    assert_redirected_to question_categories_url
    assert !QuestionCategory.exists?(question_category.id)
  end
end
