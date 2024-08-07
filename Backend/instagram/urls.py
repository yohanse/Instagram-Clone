from . import views
from rest_framework_nested.routers import DefaultRouter, NestedDefaultRouter

router = DefaultRouter()

router.register('posts', views.PostView, basename='post')
router.register('reels', views.ReelView, basename='reel')
router.register('users', views.ProfileView, basename='user')
router.register('messages', views.MessageView, basename='message')
router.register("historyMessage", views.HistoryMessageUsers, basename="historyMessage")

post_router = NestedDefaultRouter(router, "posts", lookup="post")
post_router.register("comments", views.CommentView, basename="posts-comments")
post_router.register("likes", views.LikeView, basename="posts-likes")

reel_router = NestedDefaultRouter(router, "reels", lookup="reel")
reel_router.register("comments", views.CommentView, basename="reels-comments")
reel_router.register("likes", views.LikeView, basename="reels-likes")

urlpatterns = router.urls + post_router.urls + reel_router.urls