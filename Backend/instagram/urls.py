from . import views
from rest_framework_nested.routers import DefaultRouter, NestedDefaultRouter

router = DefaultRouter()

router.register('posts', views.PostView, basename='post')
router.register('me', views.ProfileView, basename='user')

post_router = NestedDefaultRouter(router, "posts", lookup="post")
post_router.register("comments", views.CommentView, basename="posts-comments")
post_router.register("likes", views.LikeView, basename="posts-likes")

urlpatterns = router.urls + post_router.urls