from django.core.exceptions import ValidationError

def validate_not_same_user(follower, followed):
    if follower == followed:
        raise ValidationError("Follower cannot be the same as followed user")
