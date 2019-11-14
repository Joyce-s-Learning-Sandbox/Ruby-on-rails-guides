class ArticlesController < ApplicationController
  # A frequent practice is to place the standard CRUD actions in each controller in the following order: index, show, new, edit, create, update and destroy. You may use any order you choose, but keep in mind that these are public methods; as mentioned earlier in this guide, they must be placed before declaring private visibility in the controller.
  
  def index
    @articles = Article.all
    
  end 
  
  def show
    # article GET    /articles/:id(.:format)      articles#show
    @article = Article.find(params[:id])
    # We use Article.find to find the article we're interested in, passing in params[:id] to get the :id parameter from the request. We also use an instance variable (prefixed with @) to hold a reference to the article object. We do this because Rails will pass all instance variables to the view.
  end 
    
  def new
    @article = Article.new
    # The reason why we added @article = Article.new in the ArticlesController is that otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.
  end 
  
  def edit
    @article = Article.find(params[:id])
  end 
  
  def create
    # render plain: params[:article].inspect
    # The render method here is taking a very simple hash with a key of :plain and value of params[:article].inspect. The params method is the object which represents the parameters (or fields) coming in from the form. The params method returns an ActionController::Parameters object, which allows you to access the keys of the hash using either strings or symbols. In this situation, the only parameters that matter are the ones from the form.
    
    # @article = Article.new(params[:article])
    #need strong parameters
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to @article
    else 
      render 'new'
    end 
    
    # Here's what's going on: every Rails model can be initialized with its respective attributes, which are automatically mapped to the respective database columns. In the first line we do just that (remember that params[:article] contains the attributes we're interested in). Then, @article.save is responsible for saving the model in the database. Finally, we redirect the user to the show action.
    # Notice that inside the create action we use render instead of redirect_to when save returns false. The render method is used so that the @article object is passed back to the new template when it is rendered. This rendering is done within the same request as the form submission, whereas the redirect_to will tell the browser to issue another request.
    
    # With the validation now in place, when you call @article.save on an invalid article, it will return false. If you open app/controllers/articles_controller.rb again, you'll notice that we don't check the result of calling @article.save inside the create action. If @article.save fails in this situation, we need to show the form back to the user. To do this, change the new and create actions inside app/controllers/articles_controller.rb to these:
  end 
  
  def update
    # update, is used when you want to update a record that already exists, and it accepts a hash containing the attributes that you want to update. As before, if there was an error updating the article we want to show the form back to the user.
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
      # it redirects to article   /articles/:id   article#show
      # if you have an @article object, Rails will observe that it's built from the Article model, and will consequently look for the Articles controller & the show method, to show a single resource on the page.
    else 
      render 'edit'
    end 
    
  end 
  
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to articles_path
    else
      redirect_to articles_path(@article)
    end 
  end 
  
  private
  def article_params
    params.require(:article).permit(:title, :text)
  end 
end
