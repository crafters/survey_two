defmodule SurveyTwoWeb.Router do
  use SurveyTwoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
  end

  pipeline :react do
    plug :browser
    plug :put_root_layout, {SurveyTwoWeb.Layouts, :user_root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin do
    plug :browser
    plug :put_root_layout, {SurveyTwoWeb.Layouts, :admin_root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :fetch_session
    plug :accepts, ["json"]
  end

  # API routes
  scope "/api", SurveyTwoWeb.API do
    pipe_through :api

    resources "/surveys", SurveyController, only: [:show]
    delete "/surveys/:id/clear_session", SurveyController, :clear_session
    resources "/responses", ResponseController, only: [:update]
  end

  scope "/", SurveyTwoWeb do
    pipe_through :admin

    resources "/surveys", SurveyController do
      resources "/questions", QuestionController do
        post "/move", QuestionController, :move
      end

      resources "/responses", ResponseController, only: [:index, :show, :delete]
    end

    resources "/responses", ResponseController, only: [] do
      post "/add_answer", ResponseController, :add_answer, as: :add_answer
    end
  end

  scope "/", SurveyTwoWeb do
    pipe_through :react
    get "/*path", ReactController, :index
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:survey_two, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SurveyTwoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
