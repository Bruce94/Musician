from django import forms
from django.contrib.auth.forms import User
from musician.models import MusicianProfile


class UserForm(forms.ModelForm):
    error_messages = {
        'password_mismatch': "The two password fields didn't match.",
    }
    password1 = forms.CharField(label="Password",
                                widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    password2 = forms.CharField(label="Password confirmation",
                                widget=forms.PasswordInput(attrs={'class': 'form-control'}),
                                help_text="Enter the same password as above, for verification.")

    class Meta:
        model = User
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control'}),
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),

        }
        fields = ['username', 'email', 'first_name', 'last_name']

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError(
                self.error_messages['password_mismatch'],
                code='password_mismatch',
            )
        return password2

    def save(self, commit=True):
        user = super(UserForm, self).save(commit=False)
        user.set_password(self.cleaned_data["password1"])
        if commit:
            user.save()
        return user


class MusicianProfileForm(forms.ModelForm):

    class Meta:
        model = MusicianProfile
        widgets = {
            'data': forms.DateInput(attrs={'class': 'datepick', 'style': 'width: 100%'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control'}),
            'city': forms.TextInput(attrs={'class': 'form-control'}),

        }
        fields = ['bio', 'gender', 'img', 'data', 'phone_number', 'country', 'city']


#class UpdateUser(forms.ModelForm):
#    first_name = forms.CharField(required=False)
#    last_name = forms.CharField(required=False)

#    class Meta:
#        model = User
#        fields = ('first_name', 'last_name')
