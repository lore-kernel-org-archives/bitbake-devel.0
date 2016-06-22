Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id D0026731BC;
	Wed, 22 Jun 2016 15:58:19 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id v199so93363488wmv.0;
	Wed, 22 Jun 2016 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=ExCu25/XYpBeJf3f8oKO5tCBTcWVHg7Q+WWy/fs0J1M=;
	b=TTFW+C4egzjk3vLyjeQqzavyhV1stwx+2WqXUihMX6HpFNkNlGCN6sIQ5b3VyKcC/2
	Z1Kk9mCcmJNGyDvWrzz4F4LW7EAJ0xhJOnyYCR2QA3c82mhVT8yV0zNPCqe43S5BBPkr
	YK/JotuM2Alw6BEhUS2e24mT++EhD0EFGHviHLXPqDfNhUR78arbcNKBj6SjE1m0JdtK
	TzoYSHGQf7zE061YkFmBxAiX4SaAW6lqwErPFyj8tr5ZjWxm7vB6Qw9WCkrq6rZlvhLM
	8zBVgbLdw63KZ2vdIGpws1Ys97XEdbWDCPwpsYIENmxCd9jNtrtytqdvSc7cG+0lXomW
	5Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ExCu25/XYpBeJf3f8oKO5tCBTcWVHg7Q+WWy/fs0J1M=;
	b=aDe1tjoZNX37zzrE3WUER1QsvB7Kr0/W1rH7F36fuZhtRaww+9zTMnl9BXaZLponx6
	8joOtAkUtmowJEBIFsAuERMVN7P238jaqi6cQvjNWm0mMEYXwLLzU/PjpG+rN1vlvwzq
	o51NIRm+7zCzjysWtNNVJB1LW9bUi2u8fNXVNKwA6RjXrTIQXevOL1mZprTjHSI3cjAC
	YHklNLfiOHutdMVELzjUNVjlDMFYc6DrrsFIlN65Aon/YhAwHgU0pNfr0vTQtm1V6H30
	YaOejeXMlyumEse+4dUPNMVFpWe++yWktl9GHPHpxKM3I2fK0WcCVWr8qziTPmEdSdVB
	4bTQ==
X-Gm-Message-State: ALyK8tJAY2ynTmxryuCfGDWHsxP2UbyGEu5OS2dg2fAmAyVIKVpIspDN2WLKIcpOPeoxEw==
X-Received: by 10.28.26.4 with SMTP id a4mr9045126wma.92.1466611099364;
	Wed, 22 Jun 2016 08:58:19 -0700 (PDT)
Received: from localhost (ip-89-176-104-169.net.upcbroadband.cz.
	[89.176.104.169]) by smtp.gmail.com with ESMTPSA id
	r130sm1245873wmf.20.2016.06.22.08.58.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 22 Jun 2016 08:58:18 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Wed, 22 Jun 2016 17:58:39 +0200
To: openembedded-core@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Message-ID: <20160622155839.GC4153@jama>
References: <20160615073901.27831.65435@opal.openembedded.org>
MIME-Version: 1.0
In-Reply-To: <20160615073901.27831.65435@opal.openembedded.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Cc: openembedded-commits@lists.openembedded.org
Subject: Bitbake output format changed Was: [oe-commits] [bitbake] branch master updated (a3f464d -> 0219271)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Jun 2016 15:58:21 -0000
X-Groupsio-MsgNum: 7598
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 07:39:01AM +0000, git@git.openembedded.org wrote:
> rpurdie pushed a change to branch master
> in repository bitbake.
>=20
>       from  a3f464d   cooker.py: fix warn() -> warning()
>       adds  81798ab   toaster: testsjs Add call back to append elements o=
n completion of tests
>       adds  5d4172b   toaster: tweaks to recipe file downloads
>       adds  2cafb16   toaster: tests Add a BuildTest helper class
>       adds  0748177   toaster: migrate typeahead library
>       adds  afbaf32   toaster: work-around our lack of a synchronous fetc=
h for typeaheads
>       adds  69527a7   toaster: Migrate project configuration from bootstr=
ap 2 to bootstrap 3
>       adds  9f21a17   toaster: toaster tables Enable complex empty states
>       adds  4c0e07b   toaster: ToasterTable widget add an 'a' to Name in =
Exception class
>       adds  df62f38   toaster: port table for Built packages to ToasterTa=
ble
>       adds  9434d39   toaster: port Built recipes table to toastertables
>       adds  bebcef7   toaster: port Task tables to ToasterTables widget
>       adds  2418c09   toaster: port Installed packages table to ToasterTa=
ble
>       adds  927bfc2   toaster: table.js Add the ability to highlight a pa=
rticular row
>       adds  7cf2367   toaster: tests Add new build tables to tests
>       adds  566b4fb   toaster: widgets ToasterTable Catch template render=
ing exceptions
>       adds  31e7c26   toaster: Rework displaying package dependencies acr=
oss Toaster
>       adds  3f61bef   toaster-tests: maximize browser window when running=
 UI tests
>       adds  37fb9a3   toaster: fix typo which prevents filters from worki=
ng
>       adds  7c377e1   toaster: buildtables Remove links from non name fie=
lds
>       adds  f963b73   toaster: port all build analysis pages to bootstrap=
 3
>       adds  3d7f5d6   toaster: build data Fix left navigation
>       adds  70f600f   toaster: BuiltPackagesTable format empty state in p=
ackages table
>       adds  4e21817   toaster: BuildTasksTable filters remove outcome NA =
option
>       adds  e795154   toaster: bin Use python 3 for our django modules ch=
eck
>       adds  8ae2fc2   toaster: replace viewkeys() -> keys()
>       adds  bfb4488   toaster: fix migrations
>       adds  3566ecc   toaster: decode response content
>       adds  eb23a84   toaster: fix incorrect file mode
>       adds  1626e98   toaster: fix test_toaster_tables
>       adds  f66ee68   toaster: fix broken reference to urllib
>       adds  571c2b7   toaster-tests: fix tests for latest Selenium version
>       adds  c4d6796   toaster: open image files in binary mode when sendi=
ng in response
>       adds  d34546e   toaster: toastergui tests Use new BeautifulSoup syn=
tax
>       adds  3638b8e   toaster: changed python version in shebang
>       adds  c5a4893   toaster: fix wrong usage of print_exc and format_exc
>       adds  d382b2a   toaster: js tests Twitter typeahead library object =
is now ttTypeahead
>       adds  830743b   toaster: selenium tests Update unique custom image =
string and fix import
>       adds  fccc886   toaster: selenium tests Fix all_projects page and s=
ample tests
>       adds  0bdfcaf   toaster: tests Rename test settings to python compl=
iant name and fix import
>       adds  5f80dac   toaster: tests browser Fix selenium tests after boo=
tstrap3 breakage
>       adds  8c1ed57   runqueue: Change buildable/running lists to sets
>       adds  2c88afb   taskdata/runqueue: Rewrite without use of ID indire=
ction

Is it expected that this change also changes the format of summary shown
at the end of the build and failed tasks.

The commit message doesn't mention this (it even says:
=2E.
On the most part there shouldn't be user visible changes.
=2E.
There should be no functionality changes in this patch, its purely a data s=
tructure change and that is visible in the patch.
=2E.
)

So before I start fixing scripts (e.g. test-dependencies) which are trying
to parse bitbake output to work with new format, please confirm that this
was intentional and that it will stay this way.

It's also not clear why the task is mentioned twice, e.g. as:
  NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/openembedded-core/me=
ta/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe-core/openembedded-co=
re/meta/recipes-devtools/rpm/sftp.bb:do_fetch)
  ERROR: Task /OE/build/oe-core/openembedded-core/meta/recipes-devtools/rpm=
/sftp.bb:do_fetch (/OE/build/oe-core/openembedded-core/meta/recipes-devtool=
s/rpm/sftp.bb:do_fetch) failed with exit code '1'

are there cases where these 2 are different? and can both messages use the =
same "format" for task description?

Thanks

--- /OE/failures.full.before    2016-06-22 17:49:20.332082880 +0200
+++ /OE/failures.full.after     2016-06-22 17:48:57.018084068 +0200
@@ -1,4 +1,4 @@
-NOTE: Started PRServer with DBfile: /OE/build/oe-core/cache/prserv.sqlite3=
, IP: 127.0.0.1, PORT: 34615, PID: 9540
+NOTE: Started PRServer with DBfile: /OE/build/oe-core/cache/prserv.sqlite3=
, IP: 127.0.0.1, PORT: 36143, PID: 9266
 Loading cache...done.
 Loaded 1327 entries from dependency cache.
 Parsing recipes...done.
@@ -20,7 +20,7 @@
 NOTE: Preparing RunQueue
 NOTE: Executing SetScene Tasks
 NOTE: Executing RunQueue Tasks
-NOTE: Running task 512 of 548 (ID: 4, /OE/build/oe-core/openembedded-core/=
meta/recipes-devtools/rpm/sftp.bb, do_fetch)
+NOTE: Running task 512 of 548 (ID: /OE/build/oe-core/openembedded-core/met=
a/recipes-devtools/rpm/sftp.bb:do_fetch, /OE/build/oe-core/openembedded-cor=
e/meta/recipes-devtools/rpm/sftp.bb:do_fetch)
 NOTE: recipe sftp-1.0-r0: task do_fetch: Started
 WARNING: sftp-1.0-r0 do_fetch: Failed to fetch URL sftp://jama@garnet.open=
embedded.org~/setup_jenkins.sh;name=3Dsetup, attempting MIRRORS if available
 ERROR: sftp-1.0-r0 do_fetch: Fetcher failure: Fetch command failed with ex=
it code 255, output:
@@ -28,15 +28,15 @@
 Couldn't read packet: Connection reset by peer
=20
 ERROR: sftp-1.0-r0 do_fetch: Function failed: Fetcher failure for URL: 'sf=
tp://jama@garnet.openembedded.org~/setup_jenkins.sh;name=3Dsetup'. Unable t=
o fetch URL from any source.
-ERROR: Logfile of failure stored in: /OE/build/oe-core/tmp-glibc/work/i586=
-oe-linux/sftp/1.0-r0/temp/log.do_fetch.9611
+ERROR: Logfile of failure stored in: /OE/build/oe-core/tmp-glibc/work/i586=
-oe-linux/sftp/1.0-r0/temp/log.do_fetch.9339
 NOTE: recipe sftp-1.0-r0: task do_fetch: Failed
-ERROR: Task 4 (/OE/build/oe-core/openembedded-core/meta/recipes-devtools/r=
pm/sftp.bb, do_fetch) failed with exit code '1'
+ERROR: Task /OE/build/oe-core/openembedded-core/meta/recipes-devtools/rpm/=
sftp.bb:do_fetch (/OE/build/oe-core/openembedded-core/meta/recipes-devtools=
/rpm/sftp.bb:do_fetch) failed with exit code '1'
 NOTE: Tasks Summary: Attempted 534 tasks of which 533 didn't need to be re=
run and 1 failed.
 NOTE: Writing buildhistory
-NOTE: Uploading the report /OE/build/oe-core/tmp-glibc/log/error-report/er=
ror_report_20160622154916.txt to errors.yoctoproject.org:80
-NOTE: Report submitted: 200 Your entry can be found here: http://errors.yo=
ctoproject.org/Errors/Build/17616/
+NOTE: Uploading the report /OE/build/oe-core/tmp-glibc/log/error-report/er=
ror_report_20160622154853.txt to errors.yoctoproject.org:80
+NOTE: Report submitted: 200 Your entry can be found here: http://errors.yo=
ctoproject.org/Errors/Build/17615/
=20
 Summary: 1 task failed:
-  /OE/build/oe-core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb, d=
o_fetch
+  /OE/build/oe-core/openembedded-core/meta/recipes-devtools/rpm/sftp.bb:do=
_fetch
 Summary: There was 1 WARNING message shown.
 Summary: There were 2 ERROR messages shown, returning a non-zero exit code.

>       adds  8aa84ab   toaster: Remove mismerged files
>       adds  0219271   parse/ast, event: Ensure we reset registered handle=
rs during parsing
>=20
> No new revisions were added by this update.
>=20
> Summary of changes:
>  LICENSE                                            |    5 +-
>  bin/toaster                                        |    2 +-
>  lib/bb/cooker.py                                   |   72 +-
>  lib/bb/event.py                                    |    7 +
>  lib/bb/parse/ast.py                                |    4 +-
>  lib/bb/runqueue.py                                 | 1011 ++-
>  lib/bb/taskdata.py                                 |  412 +-
>  lib/bb/ui/buildinfohelper.py                       |    2 +-
>  .../management/commands/checksettings.py           |    2 +-
>  .../bldcontrol/management/commands/runbuilds.py    |    4 +-
>  .../migrations/0004_auto_20160523_1446.py          |    6 +-
>  lib/toaster/contrib/tts/runner.py                  |    4 +-
>  lib/toaster/manage.py                              |    2 +-
>  .../orm/migrations/0007_auto_20160523_1446.py      |   20 +-
>  lib/toaster/orm/models.py                          |   63 +-
>  lib/toaster/tests/browser/README                   |    7 +-
>  lib/toaster/tests/browser/selenium_helpers.py      |    1 +
>  lib/toaster/tests/browser/test_all_builds_page.py  |   15 +-
>  .../tests/browser/test_all_projects_page.py        |   13 +-
>  .../tests/browser/test_builddashboard_page.py      |   33 +-
>  lib/toaster/tests/browser/test_js_unit_tests.py    |    8 +-
>  .../tests/browser/test_new_custom_image_page.py    |    3 +-
>  .../tests/browser/test_project_config_page.py      |    5 +-
>  lib/toaster/tests/browser/test_sample.py           |    2 +-
>  lib/toaster/tests/builds/README                    |    4 +-
>  lib/toaster/toastergui/buildtables.py              |  568 ++
>  .../fixtures/toastergui-unittest-data.xml          |   91 +-
>  lib/toaster/toastergui/static/css/bootstrap.css    | 6760 ++++++++++++++=
++++++
>  .../toastergui/static/css/bootstrap.css.map        |    1 +
>  .../toastergui/static/css/bootstrap.min.css        |   13 +-
>  .../toastergui/static/css/bootstrap.min.css.map    |    1 +
>  .../static/css/bootstrap3-transition.css           |  238 +
>  lib/toaster/toastergui/static/css/default.css      |  585 +-
>  .../static/fonts/glyphicons-halflings-regular.eot  |  Bin 20290 -> 20127=
 bytes
>  .../static/fonts/glyphicons-halflings-regular.svg  |  487 +-
>  .../static/fonts/glyphicons-halflings-regular.ttf  |  Bin 41236 -> 45404=
 bytes
>  .../static/fonts/glyphicons-halflings-regular.woff |  Bin 23292 -> 23424=
 bytes
>  .../fonts/glyphicons-halflings-regular.woff2       |  Bin 0 -> 18028 byt=
es
>  .../toastergui/static/html/layer_deps_modal.html   |   38 +-
>  .../static/img/glyphicons-halflings-white.png      |  Bin 8777 -> 0 bytes
>  .../toastergui/static/img/glyphicons-halflings.png |  Bin 12799 -> 0 byt=
es
>  lib/toaster/toastergui/static/js/bootstrap.js      | 2363 +++++++
>  lib/toaster/toastergui/static/js/bootstrap.min.js  |   11 +-
>  lib/toaster/toastergui/static/js/customrecipe.js   |    4 +-
>  lib/toaster/toastergui/static/js/importlayer.js    |   11 +-
>  lib/toaster/toastergui/static/js/layerDepsModal.js |    4 +-
>  lib/toaster/toastergui/static/js/layerdetails.js   |   67 +-
>  lib/toaster/toastergui/static/js/libtoaster.js     |  146 +-
>  .../toastergui/static/js/newcustomimage_modal.js   |   76 +-
>  lib/toaster/toastergui/static/js/projectpage.js    |    8 +-
>  lib/toaster/toastergui/static/js/table.js          |   92 +-
>  lib/toaster/toastergui/static/js/tests/test.js     |    9 +-
>  .../toastergui/static/js/typeahead.jquery.js       | 1551 +++++
>  lib/toaster/toastergui/tables.py                   |  201 +-
>  lib/toaster/toastergui/templates/base.html         |   90 +-
>  .../toastergui/templates/basebuilddetailpage.html  |   47 +-
>  .../toastergui/templates/basebuildpage.html        |  118 +-
>  .../toastergui/templates/baseprojectpage.html      |   38 +-
>  .../toastergui/templates/basetable_bottom.html     |   26 +-
>  .../toastergui/templates/basetable_top.html        |  121 +-
>  lib/toaster/toastergui/templates/bpackage.html     |  108 -
>  .../toastergui/templates/builddashboard.html       |  194 +-
>  .../templates/buildinfo-toastertable.html          |   25 +
>  .../toastergui/templates/buildrequestdetails.html  |    8 +-
>  .../toastergui/templates/builds-toastertable.html  |    8 +-
>  lib/toaster/toastergui/templates/buildtime.html    |    4 -
>  .../toastergui/templates/configuration.html        |   57 +-
>  lib/toaster/toastergui/templates/configvars.html   |  150 +-
>  .../toastergui/templates/customise_btn.html        |    6 +-
>  lib/toaster/toastergui/templates/customrecipe.html |  205 +-
>  .../templates/detail_pagination_bottom.html        |   22 +-
>  .../toastergui/templates/detail_search_header.html |   78 +-
>  .../toastergui/templates/detail_sorted_header.html |    8 +-
>  lib/toaster/toastergui/templates/dirinfo.html      |   38 +-
>  .../templates/editcustomimage_modal.html           |   67 +-
>  .../toastergui/templates/filtersnippet.html        |   93 +-
>  .../templates/generic-toastertable-page.html       |    2 +-
>  lib/toaster/toastergui/templates/importlayer.html  |  260 +-
>  lib/toaster/toastergui/templates/landing.html      |   23 +-
>  .../toastergui/templates/landing_not_managed.html  |    4 +-
>  lib/toaster/toastergui/templates/layer_btn.html    |   12 +-
>  lib/toaster/toastergui/templates/layerdetails.html |  457 +-
>  lib/toaster/toastergui/templates/machine_btn.html  |   10 +-
>  lib/toaster/toastergui/templates/mrb_section.html  |  121 +-
>  .../toastergui/templates/newcustomimage.html       |   15 +-
>  .../toastergui/templates/newcustomimage_modal.html |   63 +-
>  lib/toaster/toastergui/templates/newproject.html   |   51 +-
>  .../templates/package_built_dependencies.html      |   16 +-
>  .../toastergui/templates/package_built_detail.html |    8 +-
>  .../toastergui/templates/package_detail_base.html  |   44 +-
>  .../templates/package_included_dependencies.html   |   20 +-
>  .../templates/package_included_tabs.html           |    8 +-
>  .../toastergui/templates/pkg_add_rm_btn.html       |   12 +-
>  lib/toaster/toastergui/templates/project.html      |  102 +-
>  .../templates/projectbuilds-toastertable.html      |   67 +-
>  .../toastergui/templates/projectbuilds.html        |    4 +-
>  lib/toaster/toastergui/templates/projectconf.html  | 1969 +++---
>  .../templates/projects-toastertable.html           |   58 +-
>  .../toastergui/templates/projecttopbar.html        |   86 +-
>  lib/toaster/toastergui/templates/recipe.html       |  115 +-
>  lib/toaster/toastergui/templates/recipe_btn.html   |   13 +-
>  .../toastergui/templates/recipe_packages.html      |   38 +-
>  .../toastergui/templates/recipedetails.html        |  154 +-
>  lib/toaster/toastergui/templates/recipes.html      |  113 -
>  .../templates/snippets/gitrev_popover.html         |    8 +
>  .../snippets/pkg_dependencies_popover.html         |   44 +-
>  .../snippets/pkg_revdependencies_popover.html      |   46 +-
>  lib/toaster/toastergui/templates/target.html       |  131 +-
>  lib/toaster/toastergui/templates/task.html         |  171 +-
>  lib/toaster/toastergui/templates/tasks.html        |  143 -
>  .../toastergui/templates/toastertable-filter.html  |   32 +-
>  .../toastergui/templates/toastertable-simple.html  |   94 +-
>  lib/toaster/toastergui/templates/toastertable.html |  122 +-
>  .../toastergui/templates/unavailable_artifact.html |   10 +-
>  lib/toaster/toastergui/templatetags/projecttags.py |   20 +-
>  lib/toaster/toastergui/tests.py                    |   90 +-
>  lib/toaster/toastergui/urls.py                     |   46 +-
>  lib/toaster/toastergui/views.py                    |  661 +-
>  lib/toaster/toastergui/widgets.py                  |   36 +-
>  .../{settings-test.py =3D> settings_test.py}         |    2 +-
>  120 files changed, 16436 insertions(+), 5608 deletions(-)
>  rename bitbake/lib/toaster/bldcontrol/migrations/0004_auto_20160509_0946=
=2Epy =3D> lib/toaster/bldcontrol/migrations/0004_auto_20160523_1446.py (66=
%)
>  rename bitbake/lib/toaster/orm/migrations/0007_auto_20160509_0946.py =3D=
> lib/toaster/orm/migrations/0007_auto_20160523_1446.py (69%)
>  create mode 100644 lib/toaster/toastergui/buildtables.py
>  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.css
>  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.css.map
>  create mode 100644 lib/toaster/toastergui/static/css/bootstrap.min.css.m=
ap
>  create mode 100644 lib/toaster/toastergui/static/css/bootstrap3-transiti=
on.css
>  create mode 100644 lib/toaster/toastergui/static/fonts/glyphicons-halfli=
ngs-regular.woff2
>  delete mode 100644 lib/toaster/toastergui/static/img/glyphicons-halfling=
s-white.png
>  delete mode 100644 lib/toaster/toastergui/static/img/glyphicons-halfling=
s.png
>  create mode 100644 lib/toaster/toastergui/static/js/bootstrap.js
>  create mode 100644 lib/toaster/toastergui/static/js/typeahead.jquery.js
>  delete mode 100644 lib/toaster/toastergui/templates/bpackage.html
>  create mode 100644 lib/toaster/toastergui/templates/buildinfo-toastertab=
le.html
>  delete mode 100644 lib/toaster/toastergui/templates/buildtime.html
>  delete mode 100644 lib/toaster/toastergui/templates/recipes.html
>  create mode 100644 lib/toaster/toastergui/templates/snippets/gitrev_popo=
ver.html
>  delete mode 100644 lib/toaster/toastergui/templates/tasks.html
>  rename lib/toaster/toastermain/{settings-test.py =3D> settings_test.py} =
(97%)
>=20
> --=20
> To stop receiving notification emails like this one, please contact
> the administrator of this repository.
> --=20
> _______________________________________________
> Openembedded-commits mailing list
> Openembedded-commits@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-commits

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAldqta4ACgkQN1Ujt2V2gBzAowCfQcCi2b9Pc26JYcJhMZb2K5GY
wVEAn0Z/Dm3VN+Fubx1FfiGlDxA42Fx6
=ZGKB
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
