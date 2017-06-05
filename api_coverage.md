# @title API Implementation Coverage

**IMPORTANT: This document is work in progress. Information isn't accurate.**

The Dropbox API changes frequently, so you may find out that the feature that
you need is missing. This document indicates what endpoints have been
implemented.

Full moon means fully implemented. Half moon means that the basic functionality
of the endpoint has been implemented but some options may be missing. Guess
what new moon means.

## Files namespace

API call | Status
--- | :---:
`/copy` | 🌕
`/copy_reference/get` | 🌕
`/copy_reference/save` | 🌕
`/create_folder` | 🌕
`/delete` | 🌕
`/download` | 🌔
`/get_metadata` | 🌕
`/get_preview` | 🌕
`/get_temporary_link` | 🌕
`/get_thumbnail` | 🌕
`/list_folder` | 🌕
`/list_folder/continue` | 🌕
`/list_folder/get_latest_cursor` | 🌕
`/list_folder/longpoll` | 🌕
`/list_revisions` | 🌕
`/move` | 🌕
`/permanently_delete` | 🌑
`/properties/add` | 🌑
`/properties/overwrite` | 🌑
`/properties/remove` | 🌑
`/properties/template/get` | 🌑
`/properties/template/list` | 🌑
`/properties/update` | 🌑
`/restore` | 🌕
`/save_url` | 🌕
`/save_url/check_job_status` | 🌕
`/search` | 🌔
`/upload` | 🌕
`/upload_session/append` | 🌑
`/upload_session/append_v2` | 🌕
`/upload_session/finish` | 🌕
`/upload_session/finish_batch` | 🌑
`/upload_session/finish_batch/check` | 🌑
`/upload_session/start` | 🌕

## Sharing namespace
API call | Status
--- | :---:
`/add_file_member` | 🌕
`/add_folder_member` | 🌕
`/change_file_member_access` | 🌑
`/check_job_status` | 🌑
`/check_remove_member_job_status` | 🌑
`/check_share_job_status` | 🌑
`/create_shared_link` | 🌑
`/create_shared_link_with_settings` | 🌓
`/get_file_metadata` | 🌑
`/get_file_metadata/batch` | 🌑
`/get_folder_metadata` | 🌑
`/get_shared_link_file` | 🌑
`/get_shared_link_metadata` | 🌑
`/get_shared_links` | 🌑
`/list_file_members` | 🌑
`/list_file_members/batch` | 🌑
`/list_file_members/continue` | 🌑
`/list_folder_members` | 🌕
`/list_folder_members/continue` | 🌑
`/list_folders` | 🌑
`/list_folders/continue` | 🌑
`/list_mountable_folders` | 🌑
`/list_mountable_folders/continue` | 🌑
`/list_received_files` | 🌑
`/list_received_files/continue` | 🌑
`/list_shared_links` | 🌕
`/modify_shared_link_settings` | 🌑
`/mount_folder` | 🌑
`/relinquish_file_membership` | 🌑
`/relinquish_folder_membership` | 🌑
`/remove_file_member` | 🌑
`/remove_file_member_2` | 🌑
`/remove_folder_member` | 🌑
`/revoke_shared_link` | 🌑
`/share_folder` | 🌕
`/transfer_folder` | 🌑
`/unmount_folder` | 🌑
`/unshare_file` | 🌕
`/unshare_folder` | 🌑
`/update_folder_member` | 🌑
`/update_folder_policy` | 🌑

## Users namespace

API call | Status
--- | :---:
`/get_account` | 🌕
`/get_account_batch` | 🌕
`/get_current_account` | 🌕
`/get_space_usage` | 🌕


## Dropbox Business API
Unfortunately, none of the Dropbox Business endpoints have been implemented.
If this is a problem for you, please [open an
issue](https://github.com/Jesus/dropbox_api/issues/new).
