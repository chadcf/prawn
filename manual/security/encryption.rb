# encoding: utf-8
#
# The <code>encrypt_document</code> method, as you might have already guessed, is used to
# encrypt the PDF document.
#
# Once encrypted whoever is using the document will need the user password to
# read the document. This password can be set with the
# <code>:user_password</code> option. If this is not set the document will be
# encrypted but a password will not be needed to read the document.
#
# Some permissions may be set for the regular user with the following options:
# <code>:print_document</code>, <code>:modify_contents</code>,
# <code>:copy_contents</code>, <code>:modify_annotations</code>. All this
# options default to true, so if you'd like to revoke just set them to false.
#
# A user may bypass all permissions if he provides the owner password which
# may be set with the <code>:owner_password</code> option. This option may be
# set to <code>:random</code> so that users will never be able to bypass
# permissions.
#
# There are some caveats when encrypting your PDFs. Be sure to read the source
# documentation (you can find it on lib/prawn/security.rb) before using this
# for anything super serious.
#
require File.expand_path(File.join(File.dirname(__FILE__),
                                   %w[.. example_helper]))


# Bare encryption. No password needed.
Prawn::Example.generate("bare_encryption.pdf") do
  text "See, no password was asked but the document is still encrypted."
  encrypt_document
end


# Simple password. All permissions granted.
Prawn::Example.generate("simple_password.pdf") do
  text "You was asked for a password."
  encrypt_document(:user_password => 'foo', :owner_password => 'bar')
end


# User cannot print the document.
Prawn::Example.generate("cannot_print.pdf") do
  text "If you used the user password you won't be able to print the doc."
  encrypt_document(:user_password => 'foo', :owner_password => 'bar',
                   :permissions => { :print_document => false })
end


# All permissions revoked and owner password set to random
Prawn::Example.generate("no_permissions.pdf") do
  text "You may only view this and won't be able to use the owner password."
  encrypt_document(:user_password => 'foo', :owner_password => :random,
                   :permissions => { :print_document     => false,
                                     :modify_contents    => false,
                                     :copy_contents      => false,
                                     :modify_annotations => false })
end