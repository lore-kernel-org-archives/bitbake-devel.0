Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D17CDB46E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 03:59:09 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.4050.1697083141407274325
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Oct 2023 20:59:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IV/6ubE2;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a7eef0b931so7409887b3.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Oct 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697083140; x=1697687940; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1xPIatNV327FnQSRD+ewHAeHd+x3vsCOHINy0v7+FEU=;
        b=IV/6ubE21h4IbaPm/b4MCxJr6Z86UMKS/3HaG9CTRFwXM8BofnsjYG4uTerakW/cf2
         eE8eXiGnwqq+RlXlcXYNitkPT0whHYuqmsi/cfMq22CdrW+mWQ0IuKQmHnTuonUfW9gy
         0gY9zCEgEv5LWrpGKLzZrKXVwyfIXYCexewsdMfnS0ECTRQ8UfLgNcyHu4UEebdyocJh
         N5WJoqPhKmLtdMU2YcYmMBWC2YT8X97GuKK1NzZMmWDTcTABVNJWO8P5N/bkKdH8aiJM
         XdLWc39xJZt5G3FqAncCVG48CHIf9kUF0+lcRChdst9GSy0gEsi96jqmlgaORPDhOeFq
         6FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697083140; x=1697687940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xPIatNV327FnQSRD+ewHAeHd+x3vsCOHINy0v7+FEU=;
        b=Btz3GBXTR5+w5w8o+aGQKQ3VzUDTsRXTf+Ngy/s3xLla3wVCDz3THId5uQqNkgUVgQ
         OwKcJTyIaVPT39BvPx65gFjTDh+w9SwRsUeD1UMfe+ihZoSyw/Cg7iDoBVIUpskgl2bc
         5/OW+TsXEhJlEhvO9iDQr23YmorRqB6PAakEldJOVh1irzE04DxMCVJCwTsYalR7Je4e
         9KuwvPuz3NbdAzujrprsjX8RhO5gxmMRj1X5Yf8xWZJsXF7L8bznt3zBKRpL64mU2VXu
         2Z/7DG43TQwIGHNf5EXxj7tRklOZQ3ydS8WeaK+VHhExcZ5R7SDXqrc2gjfOGnJdhj+4
         KD1w==
X-Gm-Message-State: AOJu0YzopzJuTYlmYXcy6p+i/6aCUtrHgLYuO8TiMuI5/Cb1zSi9BaBa
	reHLSVprc4PdFHodC/uk8UjEXobvPC5HIvvwcmniZPHHAxc=
X-Google-Smtp-Source: AGHT+IHjzm2Ttq+afGeqdvK/QDx1GkkEmrfH8H7tbkhYAXsEfY7J0/SZPbSujajHPtLycIBUcZMvwfiHK0Easy3TExM=
X-Received: by 2002:a25:26c4:0:b0:d78:341d:9ae7 with SMTP id
 m187-20020a2526c4000000b00d78341d9ae7mr21974201ybm.46.1697083140133; Wed, 11
 Oct 2023 20:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231003172623.72071-1-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: <20231003172623.72071-1-marlon.rodriguez-garcia@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Wed, 11 Oct 2023 20:58:48 -0700
Message-ID: <CANx9H-BjLtFXOnzj5pUO=ZG=fKa4uV0=UMiPYoJX0Akyksu5ng@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] toaster:update selenium version and
 code syntax
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000b8da9406077cf5f9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 03:59:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15211

--000000000000b8da9406077cf5f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 10:26=E2=80=AFAM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> Updated selenium version to latest 4.13.0, changed selenum specific
> version syntax elements to accomplish test success
>
>
Please update the README for how to run the tests.

https://git.yoctoproject.org/poky/tree/bitbake/lib/toaster/tests/browser/RE=
ADME


> Signed-off-by: Marlon Rodriguez Garcia <
> marlon.rodriguez-garcia@savoirfairelinux.com>
> ---
>  lib/toaster/orm/models.py                     |   2 +-
>  .../tests/browser/selenium_helpers_base.py    |   9 +-
>  .../tests/browser/test_all_builds_page.py     |  26 ++--
>  .../tests/browser/test_all_projects_page.py   |  14 +-
>  .../tests/browser/test_builddashboard_page.py |  10 +-
>  .../browser/test_most_recent_builds_states.py |  12 +-
>  .../browser/test_new_custom_image_page.py     |   4 +
>  .../tests/browser/test_new_project_page.py    |  12 +-
>  .../tests/browser/test_project_config_page.py |  29 +++--
>  .../tests/browser/test_toastertable_ui.py     |   7 +-
>  .../tests/builds/test_core_image_min.py       |   1 +
>  .../tests/functional/functional_helpers.py    |  21 +--
>  .../tests/functional/test_functional_basic.py | 120 +++++++++---------
>  .../tests/toaster-tests-requirements.txt      |   2 +-
>  lib/toaster/tests/views/test_views.py         |   4 +
>  lib/toaster/toastergui/widgets.py             |   1 +
>  16 files changed, 156 insertions(+), 118 deletions(-)
>
> diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
> index f9fcf9e4..0d503a51 100644
> --- a/lib/toaster/orm/models.py
> +++ b/lib/toaster/orm/models.py
> @@ -1733,7 +1733,7 @@ class CustomImageRecipe(Recipe):
>          packages_conf +=3D "\""
>
>          base_recipe_path =3D self.get_base_recipe_file()
> -        if base_recipe_path:
> +        if base_recipe_path and os.path.isfile(base_recipe_path):
>              base_recipe =3D open(base_recipe_path, 'r').read()
>          else:
>              # Pass back None to trigger error message to user
> diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py
> b/lib/toaster/tests/browser/selenium_helpers_base.py
> index 644d45fe..9a4e27a3 100644
> --- a/lib/toaster/tests/browser/selenium_helpers_base.py
> +++ b/lib/toaster/tests/browser/selenium_helpers_base.py
> @@ -21,6 +21,7 @@ import unittest
>
>  from selenium import webdriver
>  from selenium.webdriver.support.ui import WebDriverWait
> +from selenium.webdriver.common.by import By
>  from selenium.webdriver.common.desired_capabilities import
> DesiredCapabilities
>  from selenium.common.exceptions import NoSuchElementException, \
>          StaleElementReferenceException, TimeoutException
> @@ -32,9 +33,7 @@ def create_selenium_driver(cls,browser=3D'chrome'):
>          browser =3D env_browser
>
>      if browser =3D=3D 'chrome':
> -        return webdriver.Chrome(
> -            service_args=3D["--verbose", "--log-path=3Dselenium.log"]
> -        )
> +        return webdriver.Chrome()
>      elif browser =3D=3D 'firefox':
>          return webdriver.Firefox()
>      elif browser =3D=3D 'marionette':
> @@ -153,11 +152,11 @@ class SeleniumTestCaseBase(unittest.TestCase):
>
>      def find(self, selector):
>          """ Find single element by CSS selector """
> -        return self.driver.find_element_by_css_selector(selector)
> +        return self.driver.find_element(By.CSS_SELECTOR, selector)
>
>      def find_all(self, selector):
>          """ Find all elements matching CSS selector """
> -        return self.driver.find_elements_by_css_selector(selector)
> +        return self.driver.find_elements(By.CSS_SELECTOR, selector)
>
>      def element_exists(self, selector):
>          """
> diff --git a/lib/toaster/tests/browser/test_all_builds_page.py
> b/lib/toaster/tests/browser/test_all_builds_page.py
> index 8423d3da..d4312bb3 100644
> --- a/lib/toaster/tests/browser/test_all_builds_page.py
> +++ b/lib/toaster/tests/browser/test_all_builds_page.py
> @@ -7,7 +7,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>
> -import re
> +import re, time
>
>  from django.urls import reverse
>  from django.utils import timezone
> @@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import
> SeleniumTestCase
>
>  from orm.models import BitbakeVersion, Release, Project, Build, Target
>
> +from selenium.webdriver.common.by import By
> +
>
>  class TestAllBuildsPage(SeleniumTestCase):
>      """ Tests for all builds page /builds/ """
> @@ -91,7 +93,7 @@ class TestAllBuildsPage(SeleniumTestCase):
>          found_row =3D None
>          for row in rows:
>
> -            outcome_links =3D row.find_elements_by_css_selector(selector=
)
> +            outcome_links =3D row.find_elements(By.CSS_SELECTOR, selecto=
r)
>              if len(outcome_links) =3D=3D 1:
>                  found_row =3D row
>                  break
> @@ -131,17 +133,19 @@ class TestAllBuildsPage(SeleniumTestCase):
>          url =3D reverse('all-builds')
>          self.get(url)
>
> +        # should see a rebuild button for non-command-line builds
> +        selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 %
> build1.id
> +        time.sleep(2)
> +        run_again_button =3D self.find_all(selector)
> +        self.assertEqual(len(run_again_button), 1,
> +                         'should see a rebuild button for non-cli builds=
')
> +
>          # shouldn't see a rebuild button for command-line builds
>          selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 %
> default_build.id
>          run_again_button =3D self.find_all(selector)
>          self.assertEqual(len(run_again_button), 0,
>                           'should not see a rebuild button for cli builds=
')
>
> -        # should see a rebuild button for non-command-line builds
> -        selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 %
> build1.id
> -        run_again_button =3D self.find_all(selector)
> -        self.assertEqual(len(run_again_button), 1,
> -                         'should see a rebuild button for non-cli builds=
')
>
>      def test_tooltips_on_project_name(self):
>          """
> @@ -198,24 +202,24 @@ class TestAllBuildsPage(SeleniumTestCase):
>
>          # test recent builds area for successful build
>          element =3D self._get_build_time_element(build1)
> -        links =3D element.find_elements_by_css_selector('a')
> +        links =3D element.find_elements(By.CSS_SELECTOR, 'a')
>          msg =3D 'should be a link on the build time for a successful rec=
ent
> build'
>          self.assertEquals(len(links), 1, msg)
>
>          # test recent builds area for failed build
>          element =3D self._get_build_time_element(build2)
> -        links =3D element.find_elements_by_css_selector('a')
> +        links =3D element.find_elements(By.CSS_SELECTOR, 'a')
>          msg =3D 'should not be a link on the build time for a failed rec=
ent
> build'
>          self.assertEquals(len(links), 0, msg)
>
>          # test the time column for successful build
>          build1_row =3D self._get_row_for_build(build1)
> -        links =3D build1_row.find_elements_by_css_selector('td.time a')
> +        links =3D build1_row.find_elements(By.CSS_SELECTOR, 'td.time a')
>          msg =3D 'should be a link on the build time for a successful bui=
ld'
>          self.assertEquals(len(links), 1, msg)
>
>          # test the time column for failed build
>          build2_row =3D self._get_row_for_build(build2)
> -        links =3D build2_row.find_elements_by_css_selector('td.time a')
> +        links =3D build2_row.find_elements(By.CSS_SELECTOR, 'td.time a')
>          msg =3D 'should not be a link on the build time for a failed bui=
ld'
>          self.assertEquals(len(links), 0, msg)
> diff --git a/lib/toaster/tests/browser/test_all_projects_page.py
> b/lib/toaster/tests/browser/test_all_projects_page.py
> index 15b03400..3389d323 100644
> --- a/lib/toaster/tests/browser/test_all_projects_page.py
> +++ b/lib/toaster/tests/browser/test_all_projects_page.py
> @@ -16,6 +16,8 @@ from tests.browser.selenium_helpers import
> SeleniumTestCase
>  from orm.models import BitbakeVersion, Release, Project, Build
>  from orm.models import ProjectVariable
>
> +from selenium.webdriver.common.by import By
> +
>  class TestAllProjectsPage(SeleniumTestCase):
>      """ Browser tests for projects page /projects/ """
>
> @@ -117,7 +119,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the release text for the default project
>          selector =3D 'span[data-project-field=3D"release"] span.text-mut=
ed'
> -        element =3D
> default_project_row.find_element_by_css_selector(selector)
> +        element =3D default_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          text =3D element.text.strip()
>          self.assertEqual(text, 'Not applicable',
>                           'release should be "not applicable" for default
> project')
> @@ -127,7 +129,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the link in the release cell for the other project
>          selector =3D 'span[data-project-field=3D"release"]'
> -        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
> +        element =3D other_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          text =3D element.text.strip()
>          self.assertEqual(text, self.release.name,
>                           'release name should be shown for non-default
> project')
> @@ -152,7 +154,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the machine cell for the default project
>          selector =3D 'span[data-project-field=3D"machine"] span.text-mut=
ed'
> -        element =3D
> default_project_row.find_element_by_css_selector(selector)
> +        element =3D default_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          text =3D element.text.strip()
>          self.assertEqual(text, 'Not applicable',
>                           'machine should be not applicable for default
> project')
> @@ -162,7 +164,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the link in the machine cell for the other project
>          selector =3D 'span[data-project-field=3D"machine"]'
> -        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
> +        element =3D other_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          text =3D element.text.strip()
>          self.assertEqual(text, self.MACHINE_NAME,
>                           'machine name should be shown for non-default
> project')
> @@ -187,7 +189,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the link on the name field
>          selector =3D 'span[data-project-field=3D"name"] a'
> -        element =3D
> default_project_row.find_element_by_css_selector(selector)
> +        element =3D default_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          link_url =3D element.get_attribute('href').strip()
>          expected_url =3D reverse('projectbuilds', args=3D(
> self.default_project.id,))
>          msg =3D 'link on default project name should point to builds but
> was %s' % link_url
> @@ -198,7 +200,7 @@ class TestAllProjectsPage(SeleniumTestCase):
>
>          # check the link for the other project
>          selector =3D 'span[data-project-field=3D"name"] a'
> -        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
> +        element =3D other_project_row.find_element(By.CSS_SELECTOR,
> selector)
>          link_url =3D element.get_attribute('href').strip()
>          expected_url =3D reverse('project', args=3D(self.project.id,))
>          msg =3D 'link on project name should point to configuration but =
was
> %s' % link_url
> diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py
> b/lib/toaster/tests/browser/test_builddashboard_page.py
> index efcd89b3..1afa4a4d 100644
> --- a/lib/toaster/tests/browser/test_builddashboard_page.py
> +++ b/lib/toaster/tests/browser/test_builddashboard_page.py
> @@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import
> SeleniumTestCase
>  from orm.models import Project, Release, BitbakeVersion, Build, LogMessa=
ge
>  from orm.models import Layer, Layer_Version, Recipe, CustomImageRecipe,
> Variable
>
> +from selenium.webdriver.common.by import By
> +
>  class TestBuildDashboardPage(SeleniumTestCase):
>      """ Tests for the build dashboard /build/X """
>
> @@ -183,7 +185,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
>
>          found =3D False
>          for element in message_elements:
> -            log_message_text =3D
> element.find_element_by_tag_name('pre').text.strip()
> +            log_message_text =3D element.find_element(By.TAG_NAME,
> 'pre').text.strip()
>              text_matches =3D (log_message_text =3D=3D expected_text)
>
>              log_message_pk =3D element.get_attribute('data-log-message-i=
d')
> @@ -213,7 +215,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
>          the WebElement modal match the list of text values in expected
>          """
>          # labels containing the radio buttons we're testing for
> -        labels =3D modal.find_elements_by_css_selector(".radio")
> +        labels =3D modal.find_elements(By.CSS_SELECTOR,".radio")
>
>          labels_text =3D [lab.text for lab in labels]
>          self.assertEqual(len(labels_text), len(expected))
> @@ -248,7 +250,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
>          selector =3D '[data-role=3D"edit-custom-image-trigger"]'
>          self.click(selector)
>
> -        modal =3D self.driver.find_element_by_id('edit-custom-image-moda=
l')
> +        modal =3D self.driver.find_element(By.ID, 'edit-custom-image-mod=
al')
>          self.wait_until_visible("#edit-custom-image-modal")
>
>          # recipes we expect to see in the edit custom image modal
> @@ -270,7 +272,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
>          selector =3D '[data-role=3D"new-custom-image-trigger"]'
>          self.click(selector)
>
> -        modal =3D self.driver.find_element_by_id('new-custom-image-modal=
')
> +        modal =3D self.driver.find_element(By.ID,'new-custom-image-modal=
')
>          self.wait_until_visible("#new-custom-image-modal")
>
>          # recipes we expect to see in the new custom image modal
> diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py
> b/lib/toaster/tests/browser/test_most_recent_builds_states.py
> index 7844aaa3..a34a0928 100644
> --- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
> +++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
> @@ -6,7 +6,7 @@
>  #
>  # Copyright (C) 2013-2016 Intel Corporation
>  #
> -
> +import time
>  from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
> @@ -14,6 +14,8 @@ from tests.browser.selenium_helpers_base import Wait
>  from orm.models import Project, Build, Task, Recipe, Layer, Layer_Versio=
n
>  from bldcontrol.models import BuildRequest
>
> +from selenium.webdriver.common.by import By
> +
>  class TestMostRecentBuildsStates(SeleniumTestCase):
>      """ Test states update correctly in most recent builds area """
>
> @@ -62,7 +64,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
>          element =3D self.wait_until_visible(selector)
>
>          bar_selector =3D '#recipes-parsed-percentage-bar-%s' % build.id
> -        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
> +        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
>          self.assertEqual(bar_element.value_of_css_property('width'),
> '0px',
>              'recipe parse progress should be at 0')
>
> @@ -73,7 +75,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
>          self.get(url)
>
>          element =3D self.wait_until_visible(selector)
> -        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
> +        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
>          recipe_bar_updated =3D lambda driver: \
>              bar_element.get_attribute('style') =3D=3D 'width: 50%;'
>          msg =3D 'recipe parse progress bar should update to 50%'
> @@ -107,7 +109,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
>          element =3D self.wait_until_visible(selector)
>
>          bar_selector =3D '#build-pc-done-bar-%s' % build.id
> -        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
> +        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
>
>          task_bar_updated =3D lambda driver: \
>              bar_element.get_attribute('style') =3D=3D 'width: 50%;'
> @@ -121,7 +123,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
>          self.get(url)
>
>          element =3D self.wait_until_visible(selector)
> -        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
> +        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
>          task_bar_updated =3D lambda driver: \
>              bar_element.get_attribute('style') =3D=3D 'width: 100%;'
>          msg =3D 'tasks progress bar should update to 100%'
> diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py
> b/lib/toaster/tests/browser/test_new_custom_image_page.py
> index 9906ae42..6361f403 100644
> --- a/lib/toaster/tests/browser/test_new_custom_image_page.py
> +++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
> @@ -6,6 +6,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> +from bldcontrol.models import BuildEnvironment
>
>  from django.urls import reverse
>  from tests.browser.selenium_helpers import SeleniumTestCase
> @@ -18,6 +19,9 @@ class TestNewCustomImagePage(SeleniumTestCase):
>      CUSTOM_IMAGE_NAME =3D 'roopa-doopa'
>
>      def setUp(self):
> +        BuildEnvironment.objects.get_or_create(
> +            betype=3DBuildEnvironment.TYPE_LOCAL,
> +        )
>          release =3D Release.objects.create(
>              name=3D'baz',
>              bitbake_version=3DBitbakeVersion.objects.create(name=3D'v1')
> diff --git a/lib/toaster/tests/browser/test_new_project_page.py
> b/lib/toaster/tests/browser/test_new_project_page.py
> index e20a1f68..f4b2708f 100644
> --- a/lib/toaster/tests/browser/test_new_project_page.py
> +++ b/lib/toaster/tests/browser/test_new_project_page.py
> @@ -6,11 +6,13 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
> +import time
>
>  from django.urls import reverse
>  from tests.browser.selenium_helpers import SeleniumTestCase
>  from selenium.webdriver.support.ui import Select
>  from selenium.common.exceptions import InvalidElementStateException
> +from selenium.webdriver.common.by import By
>
>  from orm.models import Project, Release, BitbakeVersion
>
> @@ -47,13 +49,14 @@ class TestNewProjectPage(SeleniumTestCase):
>
>          url =3D reverse('newproject')
>          self.get(url)
> -
>          self.enter_text('#new-project-name', project_name)
>
>          select =3D Select(self.find('#projectversion'))
>          select.select_by_value(str(self.release.pk))
>
> +        time.sleep(1)
>          self.click("#create-project-button")
> +        time.sleep(2)
>
>          # We should get redirected to the new project's page with the
>          # notification at the top
> @@ -84,6 +87,12 @@ class TestNewProjectPage(SeleniumTestCase):
>          select =3D Select(self.find('#projectversion'))
>          select.select_by_value(str(self.release.pk))
>
> +        radio =3D self.driver.find_element(By.ID, 'type-new')
> +        radio.click()
> +
> +        self.click("#create-project-button")
> +        time.sleep(2)
> +
>          element =3D self.wait_until_visible('#hint-error-project-name')
>
>          self.assertTrue(("Project names must be unique" in element.text)=
,
> @@ -96,6 +105,7 @@ class TestNewProjectPage(SeleniumTestCase):
>          except InvalidElementStateException:
>              pass
>
> +        time.sleep(2)
>          self.assertTrue(
>              (Project.objects.filter(name=3Dproject_name).count() =3D=3D =
1),
>              "New project not found in database")
> diff --git a/lib/toaster/tests/browser/test_project_config_page.py
> b/lib/toaster/tests/browser/test_project_config_page.py
> index 944bcb26..7b21460e 100644
> --- a/lib/toaster/tests/browser/test_project_config_page.py
> +++ b/lib/toaster/tests/browser/test_project_config_page.py
> @@ -11,6 +11,7 @@ from django.urls import reverse
>  from tests.browser.selenium_helpers import SeleniumTestCase
>
>  from orm.models import BitbakeVersion, Release, Project, ProjectVariable
> +from selenium.webdriver.common.by import By
>
>  class TestProjectConfigsPage(SeleniumTestCase):
>      """ Test data at /project/X/builds is displayed correctly """
> @@ -66,7 +67,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>
>          self.enter_text('#new-imagefs_types', imagefs_type)
>
> -        checkboxes =3D
> self.driver.find_elements_by_xpath("//input[@class=3D'fs-checkbox-fstypes=
']")
> +        checkboxes =3D self.driver.find_elements(By.XPATH,
> "//input[@class=3D'fs-checkbox-fstypes']")
>
>          for checkbox in checkboxes:
>              if checkbox.get_attribute("value") =3D=3D "btrfs":
> @@ -95,7 +96,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          for checkbox in checkboxes:
>              if checkbox.get_attribute("value") =3D=3D "cpio":
>                 checkbox.click()
> -               element =3D
> self.driver.find_element_by_id('new-imagefs_types')
> +               element =3D self.driver.find_element(By.ID,
> 'new-imagefs_types')
>
>                 self.wait_until_visible('#new-imagefs_types')
>
> @@ -129,7 +130,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_START_TEXT in element.text),
> msg)
>
>          # downloads dir path has a space
> -        self.driver.find_element_by_id('new-dl_dir').clear()
> +        self.driver.find_element(By.ID, 'new-dl_dir').clear()
>          self.enter_text('#new-dl_dir', '/foo/bar a')
>
>          element =3D self.wait_until_visible('#hintError-dl_dir')
> @@ -137,7 +138,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text),
> msg)
>
>          # downloads dir path starts with ${...} but has a space
> -        self.driver.find_element_by_id('new-dl_dir').clear()
> +        self.driver.find_element(By.ID,'new-dl_dir').clear()
>          self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
>
>          element =3D self.wait_until_visible('#hintError-dl_dir')
> @@ -145,18 +146,18 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text),
> msg)
>
>          # downloads dir path starts with /
> -        self.driver.find_element_by_id('new-dl_dir').clear()
> +        self.driver.find_element(By.ID,'new-dl_dir').clear()
>          self.enter_text('#new-dl_dir', '/bar/foo')
>
> -        hidden_element =3D
> self.driver.find_element_by_id('hintError-dl_dir')
> +        hidden_element =3D
> self.driver.find_element(By.ID,'hintError-dl_dir')
>          self.assertEqual(hidden_element.is_displayed(), False,
>              'downloads directory path valid but treated as invalid')
>
>          # downloads dir path starts with ${...}
> -        self.driver.find_element_by_id('new-dl_dir').clear()
> +        self.driver.find_element(By.ID,'new-dl_dir').clear()
>          self.enter_text('#new-dl_dir', '${TOPDIR}/down')
>
> -        hidden_element =3D
> self.driver.find_element_by_id('hintError-dl_dir')
> +        hidden_element =3D
> self.driver.find_element(By.ID,'hintError-dl_dir')
>          self.assertEqual(hidden_element.is_displayed(), False,
>              'downloads directory path valid but treated as invalid')
>
> @@ -184,7 +185,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_START_TEXT in element.text),
> msg)
>
>          # path has a space
> -        self.driver.find_element_by_id('new-sstate_dir').clear()
> +        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
>          self.enter_text('#new-sstate_dir', '/foo/bar a')
>
>          element =3D self.wait_until_visible('#hintError-sstate_dir')
> @@ -192,7 +193,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text),
> msg)
>
>          # path starts with ${...} but has a space
> -        self.driver.find_element_by_id('new-sstate_dir').clear()
> +        self.driver.find_element(By.ID,'new-sstate_dir').clear()
>          self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
>
>          element =3D self.wait_until_visible('#hintError-sstate_dir')
> @@ -200,18 +201,18 @@ class TestProjectConfigsPage(SeleniumTestCase):
>          self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text),
> msg)
>
>          # path starts with /
> -        self.driver.find_element_by_id('new-sstate_dir').clear()
> +        self.driver.find_element(By.ID,'new-sstate_dir').clear()
>          self.enter_text('#new-sstate_dir', '/bar/foo')
>
> -        hidden_element =3D
> self.driver.find_element_by_id('hintError-sstate_dir')
> +        hidden_element =3D self.driver.find_element(By.ID,
> 'hintError-sstate_dir')
>          self.assertEqual(hidden_element.is_displayed(), False,
>              'sstate directory path valid but treated as invalid')
>
>          # paths starts with ${...}
> -        self.driver.find_element_by_id('new-sstate_dir').clear()
> +        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
>          self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
>
> -        hidden_element =3D
> self.driver.find_element_by_id('hintError-sstate_dir')
> +        hidden_element =3D self.driver.find_element(By.ID,
> 'hintError-sstate_dir')
>          self.assertEqual(hidden_element.is_displayed(), False,
>              'sstate directory path valid but treated as invalid')
>
> diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py
> b/lib/toaster/tests/browser/test_toastertable_ui.py
> index e82d5ec6..e00c30a8 100644
> --- a/lib/toaster/tests/browser/test_toastertable_ui.py
> +++ b/lib/toaster/tests/browser/test_toastertable_ui.py
> @@ -13,6 +13,7 @@ from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
>  from orm.models import BitbakeVersion, Release, Project, Build
> +from selenium.webdriver.common.by import By
>
>  class TestToasterTableUI(SeleniumTestCase):
>      """
> @@ -33,7 +34,7 @@ class TestToasterTableUI(SeleniumTestCase):
>          table: WebElement for a ToasterTable
>          """
>          selector =3D 'thead a.sorted'
> -        heading =3D table.find_element_by_css_selector(selector)
> +        heading =3D table.find_element(By.CSS_SELECTOR, selector)
>          return heading.get_attribute('innerHTML').strip()
>
>      def _get_datetime_from_cell(self, row, selector):
> @@ -45,7 +46,7 @@ class TestToasterTableUI(SeleniumTestCase):
>          selector: CSS selector to use to find the cell containing the
> date time
>          string
>          """
> -        cell =3D row.find_element_by_css_selector(selector)
> +        cell =3D row.find_element(By.CSS_SELECTOR, selector)
>          cell_text =3D cell.get_attribute('innerHTML').strip()
>          return datetime.strptime(cell_text, '%d/%m/%y %H:%M')
>
> @@ -105,7 +106,7 @@ class TestToasterTableUI(SeleniumTestCase):
>          self.click('#checkbox-started_on')
>
>          # sort by started_on column
> -        links =3D table.find_elements_by_css_selector('th.started_on a')
> +        links =3D table.find_elements(By.CSS_SELECTOR, 'th.started_on a'=
)
>          for link in links:
>              if link.get_attribute('innerHTML').strip() =3D=3D 'Started o=
n':
>                  link.click()
> diff --git a/lib/toaster/tests/builds/test_core_image_min.py
> b/lib/toaster/tests/builds/test_core_image_min.py
> index 44b6cbec..9cdaa15f 100644
> --- a/lib/toaster/tests/builds/test_core_image_min.py
> +++ b/lib/toaster/tests/builds/test_core_image_min.py
> @@ -26,6 +26,7 @@ class BuildCoreImageMinimal(BuildTest):
>
>      def setUp(self):
>          self.completed_build =3D self.build("core-image-minimal")
> +        self.built =3D self.target_already_built("core-image-minimal")
>
>      # Check if build name is unique - tc_id=3D795
>      def test_Build_Unique_Name(self):
> diff --git a/lib/toaster/tests/functional/functional_helpers.py
> b/lib/toaster/tests/functional/functional_helpers.py
> index 5c4ea717..c3191f66 100644
> --- a/lib/toaster/tests/functional/functional_helpers.py
> +++ b/lib/toaster/tests/functional/functional_helpers.py
> @@ -16,6 +16,9 @@ import re
>
>  from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
>  from tests.builds.buildtest import load_build_environment
> +from bldcontrol.models import BuildEnvironment
> +from selenium.webdriver.common.by import By
> +from selenium.common.exceptions import NoSuchElementException
>
>  logger =3D logging.getLogger("toaster")
>
> @@ -30,6 +33,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
>              raise RuntimeError("Please initialise django with the tests
> settings:  " \
>                  "DJANGO_SETTINGS_MODULE=3D'toastermain.settings_test'")
>
> +        if BuildEnvironment.objects.count() =3D=3D 0:
> +
> BuildEnvironment.objects.create(betype=3DBuildEnvironment.TYPE_LOCAL)
>          load_build_environment()
>
>          # start toaster
> @@ -74,8 +79,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
>          """
>          try:
>              table_element =3D self.get_table_element(table_id)
> -            element =3D table_element.find_element_by_link_text(link_tex=
t)
> -        except self.NoSuchElementException:
> +            element =3D table_element.find_element(By.LINK_TEXT, link_te=
xt)
> +        except NoSuchElementException:
>              print('no element found')
>              raise
>          return element
> @@ -85,8 +90,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
>  #return whole-table element
>              element_xpath =3D "//*[@id=3D'" + table_id + "']"
>              try:
> -                element =3D self.driver.find_element_by_xpath(element_xp=
ath)
> -            except self.NoSuchElementException:
> +                element =3D self.driver.find_element(By.XPATH,
> element_xpath)
> +            except NoSuchElementException:
>                  raise
>              return element
>          row =3D coordinate[0]
> @@ -95,8 +100,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase)=
:
>  #return whole-row element
>              element_xpath =3D "//*[@id=3D'" + table_id + "']/tbody/tr[" =
+
> str(row) + "]"
>              try:
> -                element =3D self.driver.find_element_by_xpath(element_xp=
ath)
> -            except self.NoSuchElementException:
> +                element =3D self.driver.find_element(By.XPATH,
> element_xpath)
> +            except NoSuchElementException:
>                  return False
>              return element
>  #now we are looking for an element with specified X and Y
> @@ -104,7 +109,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase=
):
>
>          element_xpath =3D "//*[@id=3D'" + table_id + "']/tbody/tr[" +
> str(row) + "]/td[" + str(column) + "]"
>          try:
> -            element =3D self.driver.find_element_by_xpath(element_xpath)
> -        except self.NoSuchElementException:
> +            element =3D self.driver.find_element(By.XPATH, element_xpath=
)
> +        except NoSuchElementException:
>              return False
>          return element
> diff --git a/lib/toaster/tests/functional/test_functional_basic.py
> b/lib/toaster/tests/functional/test_functional_basic.py
> index 5683e387..067ad99a 100644
> --- a/lib/toaster/tests/functional/test_functional_basic.py
> +++ b/lib/toaster/tests/functional/test_functional_basic.py
> @@ -10,6 +10,7 @@
>  import re
>  from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
>  from orm.models import Project
> +from selenium.webdriver.common.by import By
>
>  class FuntionalTestBasic(SeleniumFunctionalTestCase):
>
> @@ -17,10 +18,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
>      def test_create_slenium_project(self):
>          project_name =3D 'selenium-project'
>          self.get('')
> -        self.driver.find_element_by_link_text("To start building, create
> your first Toaster project").click()
> -
> self.driver.find_element_by_id("new-project-name").send_keys(project_name=
)
> -        self.driver.find_element_by_id('projectversion').click()
> -        self.driver.find_element_by_id("create-project-button").click()
> +        self.driver.find_element(By.LINK_TEXT, "To start building, creat=
e
> your first Toaster project").click()
> +        self.driver.find_element(By.ID,
> "new-project-name").send_keys(project_name)
> +        self.driver.find_element(By.ID, 'projectversion').click()
> +        self.driver.find_element(By.ID, "create-project-button").click()
>          element =3D self.wait_until_visible('#project-created-notificati=
on')
>
>  self.assertTrue(self.element_exists('#project-created-notification'),'Pr=
oject
> creation notification not shown')
>          self.assertTrue(project_name in element.text,
> @@ -35,77 +36,77 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>          self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n
> Tab does not exist')
>          project_URL=3Dself.get_URL()
> -
> self.driver.find_element_by_xpath('//a[@href=3D"'+project_URL+'"]').click=
()
> +        self.driver.find_element(By.XPATH,
> '//a[@href=3D"'+project_URL+'"]').click()
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'customimages/"'+"]").click()
> -            self.assertTrue(re.search("Custom
> images",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']").=
text),'Custom
> images information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'customimages/=
"'+"]").click()
> +            self.assertTrue(re.search("Custom
> images",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'Custom images information is not
> loading properly')
>          except:
>              self.fail(msg=3D'No Custom images tab available')
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'images/"'+"]").click()
> -            self.assertTrue(re.search("Compatible image
> recipes",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']")=
.text),'The
> Compatible image recipes information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'images/"'+"]"=
).click()
> +            self.assertTrue(re.search("Compatible image
> recipes",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Compatible image recipes
> information is not loading properly')
>          except:
>              self.fail(msg=3D'No Compatible image tab available')
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
> -            self.assertTrue(re.search("Compatible software
> recipes",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']")=
.text),'The
> Compatible software recipe information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'softwarerecip=
es/"'+"]").click()
> +            self.assertTrue(re.search("Compatible software
> recipes",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Compatible software recipe
> information is not loading properly')
>          except:
>              self.fail(msg=3D'No Compatible software recipe tab available=
')
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'machines/"'+"]").click()
> -            self.assertTrue(re.search("Compatible
> machines",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']"=
).text),'The
> Compatible machine information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'machines/"'+"=
]").click()
> +            self.assertTrue(re.search("Compatible
> machines",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Compatible machine information =
is
> not loading properly')
>          except:
>              self.fail(msg=3D'No Compatible machines tab available')
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'layers/"'+"]").click()
> -            self.assertTrue(re.search("Compatible
> layers",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']").=
text),'The
> Compatible layer information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]"=
).click()
> +            self.assertTrue(re.search("Compatible
> layers",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Compatible layer information is=
 not
> loading properly')
>          except:
>              self.fail(msg=3D'No Compatible layers tab available')
>
>          try:
> -
> self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/ul/li/a[@href=
=3D"+'"'+project_URL+'configuration"'+"]").click()
> -            self.assertTrue(re.search("Bitbake
> variables",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']=
").text),'The
> Bitbake variables information is not loading properly')
> +            self.driver.find_element(By.XPATH,
> "//*[@id=3D'config-nav']/ul/li/a[@href=3D"+'"'+project_URL+'configuration=
"'+"]").click()
> +            self.assertTrue(re.search("Bitbake
> variables",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Bitbake variables information i=
s
> not loading properly')
>          except:
>              self.fail(msg=3D'No Bitbake variables tab available')
>
>  #   testcase (1516)
>      def test_review_configuration_information(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>          project_URL=3Dself.get_URL()
>
>          try:
>
> self.assertTrue(self.element_exists('#machine-section'),'Machine section
> for the project configuration page does not exist')
> -
>  self.assertTrue(re.search("qemux86",self.driver.find_element_by_xpath("/=
/span[@id=3D'project-machine-name']").text),'The
> machine type is not assigned')
> -
>  self.driver.find_element_by_xpath("//span[@id=3D'change-machine-toggle']=
").click()
> +
>  self.assertTrue(re.search("qemux86",self.driver.find_element(By.XPATH,
> "//span[@id=3D'project-machine-name']").text),'The machine type is not
> assigned')
> +           self.driver.find_element(By.XPATH,
> "//span[@id=3D'change-machine-toggle']").click()
>             self.wait_until_visible('#select-machine-form')
>             self.wait_until_visible('#cancel-machine-change')
> -
>  self.driver.find_element_by_xpath("//form[@id=3D'select-machine-form']/a=
[@id=3D'cancel-machine-change']").click()
> +           self.driver.find_element(By.XPATH,
> "//form[@id=3D'select-machine-form']/a[@id=3D'cancel-machine-change']").c=
lick()
>          except:
>             self.fail(msg=3D'The machine information is wrong in the
> configuration page')
>
>          try:
> -           self.driver.find_element_by_id('no-most-built')
> +           self.driver.find_element(By.ID, 'no-most-built')
>          except:
>             self.fail(msg=3D'No Most built information in project detail
> page')
>
>          try:
> -           self.assertTrue(re.search("Yocto Project
> master",self.driver.find_element_by_xpath("//span[@id=3D'project-release-=
title']").text),'The
> project release is not defined')
> +           self.assertTrue(re.search("Yocto Project
> master",self.driver.find_element(By.XPATH,
> "//span[@id=3D'project-release-title']").text),'The project release is no=
t
> defined')
>          except:
>             self.fail(msg=3D'No project release title information in proj=
ect
> detail page')
>
>          try:
> -
>  self.driver.find_element_by_xpath("//div[@id=3D'layer-container']")
> -
>  self.assertTrue(re.search("3",self.driver.find_element_by_id("project-la=
yers-count").text),'There
> should be 3 layers listed in the layer count')
> -           layer_list =3D
> self.driver.find_element_by_id("layers-in-project-list")
> -           layers =3D layer_list.find_elements_by_tag_name("li")
> +           self.driver.find_element(By.XPATH,
> "//div[@id=3D'layer-container']")
> +           self.assertTrue(re.search("3",self.driver.find_element(By.ID,
> "project-layers-count").text),'There should be 3 layers listed in the lay=
er
> count')
> +           layer_list =3D self.driver.find_element(By.ID,
> "layers-in-project-list")
> +           layers =3D layer_list.find_elements(By.TAG_NAME, "li")
>             for layer in layers:
>                 if re.match ("openembedded-core",layer.text):
>                      print ("openembedded-core layer is a default layer i=
n
> the project configuration")
> @@ -121,60 +122,61 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
>  #   testcase (1517)
>      def test_verify_machine_information(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>
>          try:
>
>  self.assertTrue(self.element_exists('#machine-section'),'Machine section
> for the project configuration page does not exist')
> -
> self.assertTrue(re.search("qemux86",self.driver.find_element_by_id("proje=
ct-machine-name").text),'The
> machine type is not assigned')
> -
> self.driver.find_element_by_id("change-machine-toggle").click()
> +
> self.assertTrue(re.search("qemux86",self.driver.find_element(By.ID,
> "project-machine-name").text),'The machine type is not assigned')
> +            self.driver.find_element(By.ID,
> "change-machine-toggle").click()
>              self.wait_until_visible('#select-machine-form')
>              self.wait_until_visible('#cancel-machine-change')
> -
> self.driver.find_element_by_id("cancel-machine-change").click()
> +            self.driver.find_element(By.ID,
> "cancel-machine-change").click()
>          except:
>              self.fail(msg=3D'The machine information is wrong in the
> configuration page')
>
>  #   testcase (1518)
>      def test_verify_most_built_recipes_information(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
> +
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>          project_URL=3Dself.get_URL()
>
>          try:
> -            self.assertTrue(re.search("You haven't built any recipes
> yet",self.driver.find_element_by_id("no-most-built").text),'Default messa=
ge
> of no builds is not present')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'no-most-built']/p/a[@href=
=3D"+'"'+project_URL+'images/"'+"]").click()
> -            self.assertTrue(re.search("Compatible image
> recipes",self.driver.find_element_by_xpath("//div[@class=3D'col-md-10']")=
.text),'The
> Choose a recipe to build link  is not working  properly')
> +            self.assertTrue(re.search("You haven't built any recipes
> yet",self.driver.find_element(By.ID, "no-most-built").text),'Default
> message of no builds is not present')
> +            self.driver.find_element(By.XPATH,
> "//div[@id=3D'no-most-built']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]=
").click()
> +            self.assertTrue(re.search("Compatible image
> recipes",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-10']").text),'The Choose a recipe to build link  =
is
> not working  properly')
>          except:
>              self.fail(msg=3D'No Most built information in project detail
> page')
>
>  #   testcase (1519)
>      def test_verify_project_release_information(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>
>          try:
> -            self.assertTrue(re.search("Yocto Project
> master",self.driver.find_element_by_id("project-release-title").text),'Th=
e
> project release is not defined')
> +            self.assertTrue(re.search("Yocto Project
> master",self.driver.find_element(By.ID, "project-release-title").text),'T=
he
> project release is not defined')
>          except:
>              self.fail(msg=3D'No project release title information in
> project detail page')
>
>  #   testcase (1520)
>      def test_verify_layer_information(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>          project_URL=3Dself.get_URL()
>
>          try:
> -
>  self.driver.find_element_by_xpath("//div[@id=3D'layer-container']")
> -
>  self.assertTrue(re.search("3",self.driver.find_element_by_id("project-la=
yers-count").text),'There
> should be 3 layers listed in the layer count')
> -           layer_list =3D
> self.driver.find_element_by_id("layers-in-project-list")
> -           layers =3D layer_list.find_elements_by_tag_name("li")
> +           self.driver.find_element(By.XPATH,
> "//div[@id=3D'layer-container']")
> +           self.assertTrue(re.search("3",self.driver.find_element(By.ID,
> "project-layers-count").text),'There should be 3 layers listed in the lay=
er
> count')
> +           layer_list =3D self.driver.find_element(By.ID,
> "layers-in-project-list")
> +           layers =3D layer_list.find_element(By.TAG_NAME, "li")
>
>             for layer in layers:
>                 if re.match ("openembedded-core",layer.text):
> @@ -186,43 +188,43 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
>                 else:
>                    self.fail(msg=3D'default layers are missing from the
> project configuration')
>
> -
>  self.driver.find_element_by_xpath("//input[@id=3D'layer-add-input']")
> -
>  self.driver.find_element_by_xpath("//button[@id=3D'add-layer-btn']")
> -
>  self.driver.find_element_by_xpath("//div[@id=3D'layer-container']/form[@=
class=3D'form-inline']/p/a[@id=3D'view-compatible-layers']")
> -
>  self.driver.find_element_by_xpath("//div[@id=3D'layer-container']/form[@=
class=3D'form-inline']/p/a[@href=3D"+'"'+project_URL+'importlayer"'+"]")
> +           self.driver.find_element(By.XPATH,
> "//input[@id=3D'layer-add-input']")
> +           self.driver.find_element(By.XPATH,
> "//button[@id=3D'add-layer-btn']")
> +           self.driver.find_element(By.XPATH,
> "//div[@id=3D'layer-container']/form[@class=3D'form-inline']/p/a[@id=3D'v=
iew-compatible-layers']")
> +           self.driver.find_element(By.XPATH,
> "//div[@id=3D'layer-container']/form[@class=3D'form-inline']/p/a[@href=3D=
"+'"'+project_URL+'importlayer"'+"]")
>          except:
>              self.fail(msg=3D'No Layer information in project detail page=
')
>
>  #   testcase (1521)
>      def test_verify_project_detail_links(self):
>          self.get('')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/li/a[@hre=
f=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'global-nav']/ul/li/a[@href=3D"+'"'+'/toastergui/projects/'+=
'"'+"]").click()
>          self.wait_until_visible('#projectstable')
>          self.find_element_by_link_text_in_table('projectstable',
> 'selenium-project').click()
>          project_URL=3Dself.get_URL()
>
> -
> self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/ul[@clas=
s=3D'nav
> nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_U=
RL+'"'+"]").click()
> -
> self.assertTrue(re.search("Configuration",self.driver.find_element_by_xpa=
th("//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_U=
RL+'"'+"]").text),
> 'Configuration tab in project topbar is misspelled')
> +        self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_U=
RL+'"'+"]").click()
> +
> self.assertTrue(re.search("Configuration",self.driver.find_element(By.XPA=
TH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_U=
RL+'"'+"]").text),
> 'Configuration tab in project topbar is misspelled')
>
>          try:
> -
> self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/ul[@clas=
s=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/"'+"]").click()
> -
> self.assertTrue(re.search("Builds",self.driver.find_element_by_xpath("//d=
iv[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds =
tab
> in project topbar is misspelled')
> -
> self.driver.find_element_by_xpath("//div[@id=3D'empty-state-projectbuilds=
table']")
> +            self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/"'+"]").click()
> +
> self.assertTrue(re.search("Builds",self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds =
tab
> in project topbar is misspelled')
> +            self.driver.find_element(By.XPATH,
> "//div[@id=3D'empty-state-projectbuildstable']")
>          except:
>              self.fail(msg=3D'Builds tab information is not present')
>
>          try:
> -
> self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/ul[@clas=
s=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").click()
> -            self.assertTrue(re.search("Import
> layer",self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/u=
l[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Imp=
ort
> layer tab in project topbar is misspelled')
> -
> self.driver.find_element_by_xpath("//fieldset[@id=3D'repo-select']")
> -
> self.driver.find_element_by_xpath("//fieldset[@id=3D'git-repo']")
> +            self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").click()
> +            self.assertTrue(re.search("Import
> layer",self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Imp=
ort
> layer tab in project topbar is misspelled')
> +            self.driver.find_element(By.XPATH,
> "//fieldset[@id=3D'repo-select']")
> +            self.driver.find_element(By.XPATH,
> "//fieldset[@id=3D'git-repo']")
>          except:
>              self.fail(msg=3D'Import layer tab not loading properly')
>
>          try:
> -
> self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/ul[@clas=
s=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").click()
> -            self.assertTrue(re.search("New custom
> image",self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']/u=
l[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").text), =
'New
> custom image tab in project topbar is misspelled')
> -            self.assertTrue(re.search("Select the image recipe you want
> to
> customise",self.driver.find_element_by_xpath("//div[@class=3D'col-md-12']=
/h2").text),'The
> new custom image tab is not loading correctly')
> +            self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").click()
> +            self.assertTrue(re.search("New custom
> image",self.driver.find_element(By.XPATH,
> "//div[@id=3D'project-topbar']/ul[@class=3D'nav
> nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").text), =
'New
> custom image tab in project topbar is misspelled')
> +            self.assertTrue(re.search("Select the image recipe you want
> to customise",self.driver.find_element(By.XPATH,
> "//div[@class=3D'col-md-12']/h2").text),'The new custom image tab is not
> loading correctly')
>          except:
>              self.fail(msg=3D'New custom image tab not loading properly')
>
> diff --git a/lib/toaster/tests/toaster-tests-requirements.txt
> b/lib/toaster/tests/toaster-tests-requirements.txt
> index 4f9fcc46..f30ac070 100644
> --- a/lib/toaster/tests/toaster-tests-requirements.txt
> +++ b/lib/toaster/tests/toaster-tests-requirements.txt
> @@ -1 +1 @@
> -selenium=3D=3D2.49.2
> +selenium>=3D4.13.0
> diff --git a/lib/toaster/tests/views/test_views.py
> b/lib/toaster/tests/views/test_views.py
> index 735d596b..f962e762 100644
> --- a/lib/toaster/tests/views/test_views.py
> +++ b/lib/toaster/tests/views/test_views.py
> @@ -19,6 +19,7 @@ from orm.models import Layer_Version, Recipe
>  from orm.models import CustomImageRecipe
>  from orm.models import CustomImagePackage
>
> +from bldcontrol.models import BuildEnvironment
>  import inspect
>  import toastergui
>
> @@ -45,6 +46,9 @@ class ViewTests(TestCase):
>          self.cust_package =3D CustomImagePackage.objects.first()
>          self.package =3D Package.objects.first()
>          self.lver =3D Layer_Version.objects.first()
> +        if BuildEnvironment.objects.count() =3D=3D 0:
> +
> BuildEnvironment.objects.create(betype=3DBuildEnvironment.TYPE_LOCAL)
> +
>
>      def test_get_base_call_returns_html(self):
>          """Basic test for all-projects view"""
> diff --git a/lib/toaster/toastergui/widgets.py
> b/lib/toaster/toastergui/widgets.py
> index 53696912..6e87285c 100644
> --- a/lib/toaster/toastergui/widgets.py
> +++ b/lib/toaster/toastergui/widgets.py
> @@ -305,6 +305,7 @@ class ToasterTable(TemplateView):
>
>          self.setup_columns(**kwargs)
>
> +        self.apply_orderby('pk')
>          if search:
>              self.apply_search(search)
>          if filters:
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15177):
> https://lists.openembedded.org/g/bitbake-devel/message/15177
> Mute This Topic: https://lists.openembedded.org/mt/101738649/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000b8da9406077cf5f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 3, 2023 at 10:26=E2=80=AF=
AM Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodriguez-garcia@sa=
voirfairelinux.com">marlon.rodriguez-garcia@savoirfairelinux.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Updated sel=
enium version to latest 4.13.0, changed selenum specific version syntax ele=
ments to accomplish test success<br>
<br></blockquote><div><br></div><div>Please update the README for how to ru=
n the tests.</div><div><br></div><div><a href=3D"https://git.yoctoproject.o=
rg/poky/tree/bitbake/lib/toaster/tests/browser/README">https://git.yoctopro=
ject.org/poky/tree/bitbake/lib/toaster/tests/browser/README</a></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodrigu=
ez-garcia@savoirfairelinux.com" target=3D"_blank">marlon.rodriguez-garcia@s=
avoirfairelinux.com</a>&gt;<br>
---<br>
=C2=A0lib/toaster/orm/models.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0.../tests/browser/selenium_helpers_base.py=C2=A0 =C2=A0 |=C2=A0 =C2=
=A09 +-<br>
=C2=A0.../tests/browser/test_all_builds_page.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
26 ++--<br>
=C2=A0.../tests/browser/test_all_projects_page.py=C2=A0 =C2=A0|=C2=A0 14 +-=
<br>
=C2=A0.../tests/browser/test_builddashboard_page.py |=C2=A0 10 +-<br>
=C2=A0.../browser/test_most_recent_builds_states.py |=C2=A0 12 +-<br>
=C2=A0.../browser/test_new_custom_image_page.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A04 +<br>
=C2=A0.../tests/browser/test_new_project_page.py=C2=A0 =C2=A0 |=C2=A0 12 +-=
<br>
=C2=A0.../tests/browser/test_project_config_page.py |=C2=A0 29 +++--<br>
=C2=A0.../tests/browser/test_toastertable_ui.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A07 +-<br>
=C2=A0.../tests/builds/test_core_image_min.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
=C2=A0.../tests/functional/functional_helpers.py=C2=A0 =C2=A0 |=C2=A0 21 +-=
-<br>
=C2=A0.../tests/functional/test_functional_basic.py | 120 +++++++++--------=
-<br>
=C2=A0.../tests/toaster-tests-requirements.txt=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A02 +-<br>
=C2=A0lib/toaster/tests/views/test_views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A04 +<br>
=C2=A0lib/toaster/toastergui/widgets.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A016 files changed, 156 insertions(+), 118 deletions(-)<br>
<br>
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py<br>
index f9fcf9e4..0d503a51 100644<br>
--- a/lib/toaster/orm/models.py<br>
+++ b/lib/toaster/orm/models.py<br>
@@ -1733,7 +1733,7 @@ class CustomImageRecipe(Recipe):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0packages_conf +=3D &quot;\&quot;&quot;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base_recipe_path =3D self.get_base_recipe=
_file()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if base_recipe_path:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if base_recipe_path and os.path.isfile(base_re=
cipe_path):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base_recipe =3D open(base_r=
ecipe_path, &#39;r&#39;).read()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Pass back None to trigger=
 error message to user<br>
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toast=
er/tests/browser/selenium_helpers_base.py<br>
index 644d45fe..9a4e27a3 100644<br>
--- a/lib/toaster/tests/browser/selenium_helpers_base.py<br>
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py<br>
@@ -21,6 +21,7 @@ import unittest<br>
<br>
=C2=A0from selenium import webdriver<br>
=C2=A0from selenium.webdriver.support.ui import WebDriverWait<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
=C2=A0from selenium.webdriver.common.desired_capabilities import DesiredCap=
abilities<br>
=C2=A0from selenium.common.exceptions import NoSuchElementException, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StaleElementReferenceException, TimeoutEx=
ception<br>
@@ -32,9 +33,7 @@ def create_selenium_driver(cls,browser=3D&#39;chrome&#39;=
):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0browser =3D env_browser<br>
<br>
=C2=A0 =C2=A0 =C2=A0if browser =3D=3D &#39;chrome&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Chrome(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 service_args=3D[&quot;--verbose&=
quot;, &quot;--log-path=3Dselenium.log&quot;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Chrome()<br>
=C2=A0 =C2=A0 =C2=A0elif browser =3D=3D &#39;firefox&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return webdriver.Firefox()<br>
=C2=A0 =C2=A0 =C2=A0elif browser =3D=3D &#39;marionette&#39;:<br>
@@ -153,11 +152,11 @@ class SeleniumTestCaseBase(unittest.TestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def find(self, selector):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Find single element by=
 CSS selector &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.driver.find_element_by_css_selecto=
r(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.driver.find_element(By.CSS_SELECTO=
R, selector)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def find_all(self, selector):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Find all elements matc=
hing CSS selector &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.driver.find_elements_by_css_select=
or(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.driver.find_elements(By.CSS_SELECT=
OR, selector)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def element_exists(self, selector):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaste=
r/tests/browser/test_all_builds_page.py<br>
index 8423d3da..d4312bb3 100644<br>
--- a/lib/toaster/tests/browser/test_all_builds_page.py<br>
+++ b/lib/toaster/tests/browser/test_all_builds_page.py<br>
@@ -7,7 +7,7 @@<br>
=C2=A0# SPDX-License-Identifier: GPL-2.0-only<br>
=C2=A0#<br>
<br>
-import re<br>
+import re, time<br>
<br>
=C2=A0from django.urls import reverse<br>
=C2=A0from django.utils import timezone<br>
@@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import SeleniumTestCa=
se<br>
<br>
=C2=A0from orm.models import BitbakeVersion, Release, Project, Build, Targe=
t<br>
<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
+<br>
<br>
=C2=A0class TestAllBuildsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Tests for all builds page /builds/ &=
quot;&quot;&quot;<br>
@@ -91,7 +93,7 @@ class TestAllBuildsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found_row =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for row in rows:<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outcome_links =3D row.find_eleme=
nts_by_css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 outcome_links =3D row.find_eleme=
nts(By.CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if len(outcome_links) =3D=
=3D 1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found_row =3D=
 row<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break<br>
@@ -131,17 +133,19 @@ class TestAllBuildsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D reverse(&#39;all-builds&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(url)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # should see a rebuild button for non-command-=
line builds<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 selector =3D &#39;div[data-latest-build-result=
=3D&quot;%s&quot;] .rebuild-btn&#39; % <a href=3D"http://build1.id" rel=3D"=
noreferrer" target=3D"_blank">build1.id</a><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 run_again_button =3D self.find_all(selector)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(len(run_again_button), 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;should see a rebuild button for non-cli builds&#39;)<=
br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# shouldn&#39;t see a rebuild button for =
command-line builds<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;div[data-latest-build-r=
esult=3D&quot;%s&quot;] .rebuild-btn&#39; % <a href=3D"http://default_build=
.id" rel=3D"noreferrer" target=3D"_blank">default_build.id</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run_again_button =3D self.find_all(select=
or)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(len(run_again_button), 0=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;should not see a rebuild button for cli builds&#39;)=
<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 # should see a rebuild button for non-command-=
line builds<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 selector =3D &#39;div[data-latest-build-result=
=3D&quot;%s&quot;] .rebuild-btn&#39; % <a href=3D"http://build1.id" rel=3D"=
noreferrer" target=3D"_blank">build1.id</a><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 run_again_button =3D self.find_all(selector)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(len(run_again_button), 1,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;should see a rebuild button for non-cli builds&#39;)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_tooltips_on_project_name(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -198,24 +202,24 @@ class TestAllBuildsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# test recent builds area for successful =
build<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self._get_build_time_element(=
build1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D element.find_elements_by_css_selecto=
r(&#39;a&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D element.find_elements(By.CSS_SELECTO=
R, &#39;a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;should be a link on the buil=
d time for a successful recent build&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEquals(len(links), 1, msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# test recent builds area for failed buil=
d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self._get_build_time_element(=
build2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D element.find_elements_by_css_selecto=
r(&#39;a&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D element.find_elements(By.CSS_SELECTO=
R, &#39;a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;should not be a link on the =
build time for a failed recent build&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEquals(len(links), 0, msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# test the time column for successful bui=
ld<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build1_row =3D self._get_row_for_build(bu=
ild1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D build1_row.find_elements_by_css_sele=
ctor(&#39;td.time a&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D build1_row.find_elements(By.CSS_SELE=
CTOR, &#39;td.time a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;should be a link on the buil=
d time for a successful build&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEquals(len(links), 1, msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# test the time column for failed build<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build2_row =3D self._get_row_for_build(bu=
ild2)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D build2_row.find_elements_by_css_sele=
ctor(&#39;td.time a&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D build2_row.find_elements(By.CSS_SELE=
CTOR, &#39;td.time a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;should not be a link on the =
build time for a failed build&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEquals(len(links), 0, msg)<br>
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toas=
ter/tests/browser/test_all_projects_page.py<br>
index 15b03400..3389d323 100644<br>
--- a/lib/toaster/tests/browser/test_all_projects_page.py<br>
+++ b/lib/toaster/tests/browser/test_all_projects_page.py<br>
@@ -16,6 +16,8 @@ from tests.browser.selenium_helpers import SeleniumTestCa=
se<br>
=C2=A0from orm.models import BitbakeVersion, Release, Project, Build<br>
=C2=A0from orm.models import ProjectVariable<br>
<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
+<br>
=C2=A0class TestAllProjectsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Browser tests for projects page /pro=
jects/ &quot;&quot;&quot;<br>
<br>
@@ -117,7 +119,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the release text for the default =
project<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;release&quot;] span.text-muted&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element_b=
y_css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element(B=
y.CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D element.text.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(text, &#39;Not applicabl=
e&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;release should be &quot;not applicable&quot; for def=
ault project&#39;)<br>
@@ -127,7 +129,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the link in the release cell for =
the other project<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;release&quot;]&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element_by_=
css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element(By.=
CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D element.text.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(text, <a href=3D"http://=
self.release.name" rel=3D"noreferrer" target=3D"_blank">self.release.name</=
a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;release name should be shown for non-default project=
&#39;)<br>
@@ -152,7 +154,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the machine cell for the default =
project<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;machine&quot;] span.text-muted&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element_b=
y_css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element(B=
y.CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D element.text.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(text, &#39;Not applicabl=
e&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;machine should be not applicable for default project=
&#39;)<br>
@@ -162,7 +164,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the link in the machine cell for =
the other project<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;machine&quot;]&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element_by_=
css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element(By.=
CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text =3D element.text.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(text, self.MACHINE_NAME,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;machine name should be shown for non-default project=
&#39;)<br>
@@ -187,7 +189,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the link on the name field<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;name&quot;] a&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element_b=
y_css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D default_project_row.find_element(B=
y.CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_url =3D element.get_attribute(&#39;h=
ref&#39;).strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_url =3D reverse(&#39;projectbuil=
ds&#39;, args=3D(<a href=3D"http://self.default_project.id" rel=3D"noreferr=
er" target=3D"_blank">self.default_project.id</a>,))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;link on default project name=
 should point to builds but was %s&#39; % link_url<br>
@@ -198,7 +200,7 @@ class TestAllProjectsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# check the link for the other project<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;span[data-project-field=
=3D&quot;name&quot;] a&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element_by_=
css_selector(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D other_project_row.find_element(By.=
CSS_SELECTOR, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_url =3D element.get_attribute(&#39;h=
ref&#39;).strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expected_url =3D reverse(&#39;project&#39=
;, args=3D(<a href=3D"http://self.project.id" rel=3D"noreferrer" target=3D"=
_blank">self.project.id</a>,))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;link on project name should =
point to configuration but was %s&#39; % link_url<br>
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/to=
aster/tests/browser/test_builddashboard_page.py<br>
index efcd89b3..1afa4a4d 100644<br>
--- a/lib/toaster/tests/browser/test_builddashboard_page.py<br>
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py<br>
@@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import SeleniumTestCa=
se<br>
=C2=A0from orm.models import Project, Release, BitbakeVersion, Build, LogMe=
ssage<br>
=C2=A0from orm.models import Layer, Layer_Version, Recipe, CustomImageRecip=
e, Variable<br>
<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
+<br>
=C2=A0class TestBuildDashboardPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Tests for the build dashboard /build=
/X &quot;&quot;&quot;<br>
<br>
@@ -183,7 +185,7 @@ class TestBuildDashboardPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0found =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for element in message_elements:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_message_text =3D element.fin=
d_element_by_tag_name(&#39;pre&#39;).text.strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 log_message_text =3D element.fin=
d_element(By.TAG_NAME, &#39;pre&#39;).text.strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0text_matches =3D (log_messa=
ge_text =3D=3D expected_text)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_message_pk =3D element.=
get_attribute(&#39;data-log-message-id&#39;)<br>
@@ -213,7 +215,7 @@ class TestBuildDashboardPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the WebElement modal match the list of te=
xt values in expected<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# labels containing the radio buttons we&=
#39;re testing for<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 labels =3D modal.find_elements_by_css_selector=
(&quot;.radio&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 labels =3D modal.find_elements(By.CSS_SELECTOR=
,&quot;.radio&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0labels_text =3D [lab.text for lab in labe=
ls]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(len(labels_text), len(ex=
pected))<br>
@@ -248,7 +250,7 @@ class TestBuildDashboardPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;[data-role=3D&quot;edit=
-custom-image-trigger&quot;]&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.click(selector)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 modal =3D self.driver.find_element_by_id(&#39;=
edit-custom-image-modal&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 modal =3D self.driver.find_element(By.ID, &#39=
;edit-custom-image-modal&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&quot;#edit-custo=
m-image-modal&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# recipes we expect to see in the edit cu=
stom image modal<br>
@@ -270,7 +272,7 @@ class TestBuildDashboardPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;[data-role=3D&quot;new-=
custom-image-trigger&quot;]&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.click(selector)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 modal =3D self.driver.find_element_by_id(&#39;=
new-custom-image-modal&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 modal =3D self.driver.find_element(By.ID,&#39;=
new-custom-image-modal&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&quot;#new-custom=
-image-modal&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# recipes we expect to see in the new cus=
tom image modal<br>
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/=
lib/toaster/tests/browser/test_most_recent_builds_states.py<br>
index 7844aaa3..a34a0928 100644<br>
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py<br>
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py<br>
@@ -6,7 +6,7 @@<br>
=C2=A0#<br>
=C2=A0# Copyright (C) 2013-2016 Intel Corporation<br>
=C2=A0#<br>
-<br>
+import time<br>
=C2=A0from django.urls import reverse<br>
=C2=A0from django.utils import timezone<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
@@ -14,6 +14,8 @@ from tests.browser.selenium_helpers_base import Wait<br>
=C2=A0from orm.models import Project, Build, Task, Recipe, Layer, Layer_Ver=
sion<br>
=C2=A0from bldcontrol.models import BuildRequest<br>
<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
+<br>
=C2=A0class TestMostRecentBuildsStates(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Test states update correctly in most=
 recent builds area &quot;&quot;&quot;<br>
<br>
@@ -62,7 +64,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(selec=
tor)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bar_selector =3D &#39;#recipes-parsed-per=
centage-bar-%s&#39; % <a href=3D"http://build.id" rel=3D"noreferrer" target=
=3D"_blank">build.id</a><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element_by_css_se=
lector(bar_selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element(By.CSS_SE=
LECTOR, bar_selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(bar_element.value_of_css=
_property(&#39;width&#39;), &#39;0px&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;recipe parse progress =
should be at 0&#39;)<br>
<br>
@@ -73,7 +75,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(url)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(selec=
tor)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element_by_css_se=
lector(bar_selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element(By.CSS_SE=
LECTOR, bar_selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recipe_bar_updated =3D lambda driver: \<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bar_element.get_attribute(&=
#39;style&#39;) =3D=3D &#39;width: 50%;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;recipe parse progress bar sh=
ould update to 50%&#39;<br>
@@ -107,7 +109,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(selec=
tor)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bar_selector =3D &#39;#build-pc-done-bar-=
%s&#39; % <a href=3D"http://build.id" rel=3D"noreferrer" target=3D"_blank">=
build.id</a><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element_by_css_se=
lector(bar_selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element(By.CSS_SE=
LECTOR, bar_selector)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0task_bar_updated =3D lambda driver: \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bar_element.get_attribute(&=
#39;style&#39;) =3D=3D &#39;width: 50%;&#39;<br>
@@ -121,7 +123,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(url)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(selec=
tor)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element_by_css_se=
lector(bar_selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bar_element =3D element.find_element(By.CSS_SE=
LECTOR, bar_selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0task_bar_updated =3D lambda driver: \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bar_element.get_attribute(&=
#39;style&#39;) =3D=3D &#39;width: 100%;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg =3D &#39;tasks progress bar should up=
date to 100%&#39;<br>
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/=
toaster/tests/browser/test_new_custom_image_page.py<br>
index 9906ae42..6361f403 100644<br>
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py<br>
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py<br>
@@ -6,6 +6,7 @@<br>
=C2=A0#<br>
=C2=A0# SPDX-License-Identifier: GPL-2.0-only<br>
=C2=A0#<br>
+from bldcontrol.models import BuildEnvironment<br>
<br>
=C2=A0from django.urls import reverse<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
@@ -18,6 +19,9 @@ class TestNewCustomImagePage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0CUSTOM_IMAGE_NAME =3D &#39;roopa-doopa&#39;<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BuildEnvironment.objects.get_or_create(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 betype=3DBuildEnvironment.TYPE_L=
OCAL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0release =3D Release.objects.create(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name=3D&#39;baz&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitbake_version=3DBitbakeVe=
rsion.objects.create(name=3D&#39;v1&#39;)<br>
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toast=
er/tests/browser/test_new_project_page.py<br>
index e20a1f68..f4b2708f 100644<br>
--- a/lib/toaster/tests/browser/test_new_project_page.py<br>
+++ b/lib/toaster/tests/browser/test_new_project_page.py<br>
@@ -6,11 +6,13 @@<br>
=C2=A0#<br>
=C2=A0# SPDX-License-Identifier: GPL-2.0-only<br>
=C2=A0#<br>
+import time<br>
<br>
=C2=A0from django.urls import reverse<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
=C2=A0from selenium.webdriver.support.ui import Select<br>
=C2=A0from selenium.common.exceptions import InvalidElementStateException<b=
r>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
<br>
=C2=A0from orm.models import Project, Release, BitbakeVersion<br>
<br>
@@ -47,13 +49,14 @@ class TestNewProjectPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D reverse(&#39;newproject&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(url)<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-project-name&#3=
9;, project_name)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select =3D Select(self.find(&#39;#project=
version&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select.select_by_value(str(<a href=3D"htt=
p://self.release.pk" rel=3D"noreferrer" target=3D"_blank">self.release.pk</=
a>))<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.click(&quot;#create-project-button&q=
uot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We should get redirected to the new pro=
ject&#39;s page with the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# notification at the top<br>
@@ -84,6 +87,12 @@ class TestNewProjectPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select =3D Select(self.find(&#39;#project=
version&#39;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select.select_by_value(str(<a href=3D"htt=
p://self.release.pk" rel=3D"noreferrer" target=3D"_blank">self.release.pk</=
a>))<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 radio =3D self.driver.find_element(By.ID, &#39=
;type-new&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 radio.click()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.click(&quot;#create-project-button&quot;)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#hint-error-project-name&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((&quot;Project names must=
 be unique&quot; in element.text),<br>
@@ -96,6 +105,7 @@ class TestNewProjectPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except InvalidElementStateException:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 time.sleep(2)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Project.objects.filter(nam=
e=3Dproject_name).count() =3D=3D 1),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;New project not found=
 in database&quot;)<br>
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/to=
aster/tests/browser/test_project_config_page.py<br>
index 944bcb26..7b21460e 100644<br>
--- a/lib/toaster/tests/browser/test_project_config_page.py<br>
+++ b/lib/toaster/tests/browser/test_project_config_page.py<br>
@@ -11,6 +11,7 @@ from django.urls import reverse<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
<br>
=C2=A0from orm.models import BitbakeVersion, Release, Project, ProjectVaria=
ble<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
<br>
=C2=A0class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Test data at /project/X/builds is di=
splayed correctly &quot;&quot;&quot;<br>
@@ -66,7 +67,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-imagefs_types&#=
39;, imagefs_type)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 checkboxes =3D self.driver.find_elements_by_xp=
ath(&quot;//input[@class=3D&#39;fs-checkbox-fstypes&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 checkboxes =3D self.driver.find_elements(By.XP=
ATH, &quot;//input[@class=3D&#39;fs-checkbox-fstypes&#39;]&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for checkbox in checkboxes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if checkbox.get_attribute(&=
quot;value&quot;) =3D=3D &quot;btrfs&quot;:<br>
@@ -95,7 +96,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for checkbox in checkboxes:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if checkbox.get_attribute(&=
quot;value&quot;) =3D=3D &quot;cpio&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 checkbox.click()<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.dr=
iver.find_element_by_id(&#39;new-imagefs_types&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.dr=
iver.find_element(By.ID, &#39;new-imagefs_types&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_until_vis=
ible(&#39;#new-imagefs_types&#39;)<br>
<br>
@@ -129,7 +130,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_START_=
TEXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# downloads dir path has a space<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-dl_dir=
&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &#39;new-dl_di=
r&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-dl_dir&#39;, &#=
39;/foo/bar a&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#hintError-dl_dir&#39;)<br>
@@ -137,7 +138,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_CHAR_T=
EXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# downloads dir path starts with ${...} b=
ut has a space<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-dl_dir=
&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID,&#39;new-dl_dir=
&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-dl_dir&#39;, &#=
39;${TOPDIR}/down foo&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#hintError-dl_dir&#39;)<br>
@@ -145,18 +146,18 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_CHAR_T=
EXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# downloads dir path starts with /<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-dl_dir=
&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID,&#39;new-dl_dir=
&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-dl_dir&#39;, &#=
39;/bar/foo&#39;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element_by=
_id(&#39;hintError-dl_dir&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element(By=
.ID,&#39;hintError-dl_dir&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(hidden_element.is_displa=
yed(), False,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;downloads directory pa=
th valid but treated as invalid&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# downloads dir path starts with ${...}<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-dl_dir=
&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID,&#39;new-dl_dir=
&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-dl_dir&#39;, &#=
39;${TOPDIR}/down&#39;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element_by=
_id(&#39;hintError-dl_dir&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element(By=
.ID,&#39;hintError-dl_dir&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(hidden_element.is_displa=
yed(), False,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;downloads directory pa=
th valid but treated as invalid&#39;)<br>
<br>
@@ -184,7 +185,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_START_=
TEXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# path has a space<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-sstate=
_dir&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &#39;new-sstat=
e_dir&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-sstate_dir&#39;=
, &#39;/foo/bar a&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#hintError-sstate_dir&#39;)<br>
@@ -192,7 +193,7 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_CHAR_T=
EXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# path starts with ${...} but has a space=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-sstate=
_dir&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID,&#39;new-sstate=
_dir&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-sstate_dir&#39;=
, &#39;${TOPDIR}/down foo&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#hintError-sstate_dir&#39;)<br>
@@ -200,18 +201,18 @@ class TestProjectConfigsPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue((self.INVALID_PATH_CHAR_T=
EXT in element.text), msg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# path starts with /<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-sstate=
_dir&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID,&#39;new-sstate=
_dir&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-sstate_dir&#39;=
, &#39;/bar/foo&#39;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element_by=
_id(&#39;hintError-sstate_dir&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element(By=
.ID, &#39;hintError-sstate_dir&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(hidden_element.is_displa=
yed(), False,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sstate directory path =
valid but treated as invalid&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# paths starts with ${...}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;new-sstate=
_dir&#39;).clear()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &#39;new-sstat=
e_dir&#39;).clear()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.enter_text(&#39;#new-sstate_dir&#39;=
, &#39;${TOPDIR}/down&#39;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element_by=
_id(&#39;hintError-sstate_dir&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hidden_element =3D self.driver.find_element(By=
.ID, &#39;hintError-sstate_dir&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(hidden_element.is_displa=
yed(), False,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sstate directory path =
valid but treated as invalid&#39;)<br>
<br>
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toaste=
r/tests/browser/test_toastertable_ui.py<br>
index e82d5ec6..e00c30a8 100644<br>
--- a/lib/toaster/tests/browser/test_toastertable_ui.py<br>
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py<br>
@@ -13,6 +13,7 @@ from django.urls import reverse<br>
=C2=A0from django.utils import timezone<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
=C2=A0from orm.models import BitbakeVersion, Release, Project, Build<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
<br>
=C2=A0class TestToasterTableUI(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
@@ -33,7 +34,7 @@ class TestToasterTableUI(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table: WebElement for a ToasterTable<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector =3D &#39;thead a.sorted&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 heading =3D table.find_element_by_css_selector=
(selector)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 heading =3D table.find_element(By.CSS_SELECTOR=
, selector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return heading.get_attribute(&#39;innerHT=
ML&#39;).strip()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _get_datetime_from_cell(self, row, selector):<br>
@@ -45,7 +46,7 @@ class TestToasterTableUI(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selector: CSS selector to use to find the=
 cell containing the date time<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cell =3D row.find_element_by_css_selector(sele=
ctor)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cell =3D row.find_element(By.CSS_SELECTOR, sel=
ector)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cell_text =3D cell.get_attribute(&#39;inn=
erHTML&#39;).strip()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return datetime.strptime(cell_text, &#39;=
%d/%m/%y %H:%M&#39;)<br>
<br>
@@ -105,7 +106,7 @@ class TestToasterTableUI(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.click(&#39;#checkbox-started_on&#39;=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# sort by started_on column<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D table.find_elements_by_css_selector(=
&#39;th.started_on a&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D table.find_elements(By.CSS_SELECTOR,=
 &#39;th.started_on a&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for link in links:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if link.get_attribute(&#39;=
innerHTML&#39;).strip() =3D=3D &#39;Started on&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link.click()<=
br>
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaster/=
tests/builds/test_core_image_min.py<br>
index 44b6cbec..9cdaa15f 100644<br>
--- a/lib/toaster/tests/builds/test_core_image_min.py<br>
+++ b/lib/toaster/tests/builds/test_core_image_min.py<br>
@@ -26,6 +26,7 @@ class BuildCoreImageMinimal(BuildTest):<br>
<br>
=C2=A0 =C2=A0 =C2=A0def setUp(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.completed_build =3D self.build(&quot=
;core-image-minimal&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.built =3D self.target_already_built(&quot=
;core-image-minimal&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Check if build name is unique - tc_id=3D795<br>
=C2=A0 =C2=A0 =C2=A0def test_Build_Unique_Name(self):<br>
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toast=
er/tests/functional/functional_helpers.py<br>
index 5c4ea717..c3191f66 100644<br>
--- a/lib/toaster/tests/functional/functional_helpers.py<br>
+++ b/lib/toaster/tests/functional/functional_helpers.py<br>
@@ -16,6 +16,9 @@ import re<br>
<br>
=C2=A0from tests.browser.selenium_helpers_base import SeleniumTestCaseBase<=
br>
=C2=A0from tests.builds.buildtest import load_build_environment<br>
+from bldcontrol.models import BuildEnvironment<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
+from selenium.common.exceptions import NoSuchElementException<br>
<br>
=C2=A0logger =3D logging.getLogger(&quot;toaster&quot;)<br>
<br>
@@ -30,6 +33,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise RuntimeError(&quot;Pl=
ease initialise django with the tests settings:=C2=A0 &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;DJANGO_=
SETTINGS_MODULE=3D&#39;toastermain.settings_test&#39;&quot;)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if BuildEnvironment.objects.count() =3D=3D 0:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BuildEnvironment.objects.create(=
betype=3DBuildEnvironment.TYPE_LOCAL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_build_environment()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# start toaster<br>
@@ -74,8 +79,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0table_element =3D self.get_=
table_element(table_id)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D table_element.find_e=
lement_by_link_text(link_text)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except self.NoSuchElementException:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D table_element.find_e=
lement(By.LINK_TEXT, link_text)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except NoSuchElementException:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&#39;no element found=
&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return element<br>
@@ -85,8 +90,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):<b=
r>
=C2=A0#return whole-table element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element_xpath =3D &quot;//*=
[@id=3D&#39;&quot; + table_id + &quot;&#39;]&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.d=
river.find_element_by_xpath(element_xpath)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except self.NoSuchElementExcepti=
on:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.d=
river.find_element(By.XPATH, element_xpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except NoSuchElementException:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0row =3D coordinate[0]<br>
@@ -95,8 +100,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):<=
br>
=C2=A0#return whole-row element<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element_xpath =3D &quot;//*=
[@id=3D&#39;&quot; + table_id + &quot;&#39;]/tbody/tr[&quot; + str(row) + &=
quot;]&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.d=
river.find_element_by_xpath(element_xpath)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except self.NoSuchElementExcepti=
on:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.d=
river.find_element(By.XPATH, element_xpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except NoSuchElementException:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return element<br>
=C2=A0#now we are looking for an element with specified X and Y<br>
@@ -104,7 +109,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element_xpath =3D &quot;//*[@id=3D&#39;&q=
uot; + table_id + &quot;&#39;]/tbody/tr[&quot; + str(row) + &quot;]/td[&quo=
t; + str(column) + &quot;]&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.driver.find_ele=
ment_by_xpath(element_xpath)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except self.NoSuchElementException:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 element =3D self.driver.find_ele=
ment(By.XPATH, element_xpath)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except NoSuchElementException:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return element<br>
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/to=
aster/tests/functional/test_functional_basic.py<br>
index 5683e387..067ad99a 100644<br>
--- a/lib/toaster/tests/functional/test_functional_basic.py<br>
+++ b/lib/toaster/tests/functional/test_functional_basic.py<br>
@@ -10,6 +10,7 @@<br>
=C2=A0import re<br>
=C2=A0from tests.functional.functional_helpers import SeleniumFunctionalTes=
tCase<br>
=C2=A0from orm.models import Project<br>
+from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferrer" ta=
rget=3D"_blank">selenium.webdriver.common.by</a> import By<br>
<br>
=C2=A0class FuntionalTestBasic(SeleniumFunctionalTestCase):<br>
<br>
@@ -17,10 +18,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):<b=
r>
=C2=A0 =C2=A0 =C2=A0def test_create_slenium_project(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_name =3D &#39;selenium-project&#3=
9;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_link_text(&quot;To=
 start building, create your first Toaster project&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&quot;new-proje=
ct-name&quot;).send_keys(project_name)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&#39;projectver=
sion&#39;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&quot;create-pr=
oject-button&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.LINK_TEXT, &quot;T=
o start building, create your first Toaster project&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &quot;new-proj=
ect-name&quot;).send_keys(project_name)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &#39;projectve=
rsion&#39;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, &quot;create-p=
roject-button&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0element =3D self.wait_until_visible(&#39;=
#project-created-notification&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(self.element_exists(&#39;=
#project-created-notification&#39;),&#39;Project creation notification not =
shown&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(project_name in element.t=
ext,<br>
@@ -35,77 +36,77 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(self.element_exists(&#39;=
#config-nav&#39;),&#39;Configuration Tab does not exist&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_URL=3Dself.get_URL()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&#39;//a[@hr=
ef=3D&quot;&#39;+project_URL+&#39;&quot;]&#39;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &#39;//a[@h=
ref=3D&quot;&#39;+project_URL+&#39;&quot;]&#39;).click()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;customimages/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Custom images&quot;,self.driver.find_element_by_xpath(&quot;//div[@class=3D=
&#39;col-md-10&#39;]&quot;).text),&#39;Custom images information is not loa=
ding properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;customimages/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Custom images&quot;,self.driver.find_element(By.XPATH, &quot;//div[@class=
=3D&#39;col-md-10&#39;]&quot;).text),&#39;Custom images information is not =
loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Cus=
tom images tab available&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;images/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible image recipes&quot;,self.driver.find_element_by_xpath(&quot;//di=
v[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible image reci=
pes information is not loading properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;images/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible image recipes&quot;,self.driver.find_element(By.XPATH, &quot;//d=
iv[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible image rec=
ipes information is not loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Com=
patible image tab available&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;softwarerecipes/&quot;&#39;+&quot;]&quot;).click()<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible software recipes&quot;,self.driver.find_element_by_xpath(&quot;/=
/div[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible softwar=
e recipe information is not loading properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;softwarerecipes/&quot;&#39;+&quot;]&quot;).click()<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible software recipes&quot;,self.driver.find_element(By.XPATH, &quot;=
//div[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible softwa=
re recipe information is not loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Com=
patible software recipe tab available&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;machines/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible machines&quot;,self.driver.find_element_by_xpath(&quot;//div[@cl=
ass=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible machine informa=
tion is not loading properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;machines/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible machines&quot;,self.driver.find_element(By.XPATH, &quot;//div[@c=
lass=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible machine inform=
ation is not loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Com=
patible machines tab available&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;layers/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible layers&quot;,self.driver.find_element_by_xpath(&quot;//div[@clas=
s=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible layer information=
 is not loading properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;layers/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible layers&quot;,self.driver.find_element(By.XPATH, &quot;//div[@cla=
ss=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Compatible layer informatio=
n is not loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Com=
patible layers tab available&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&=
#39;+project_URL+&#39;configuration&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Bitbake variables&quot;,self.driver.find_element_by_xpath(&quot;//div[@clas=
s=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Bitbake variables informatio=
n is not loading properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//*[@id=3D&#39;config-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;configuration&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Bitbake variables&quot;,self.driver.find_element(By.XPATH, &quot;//div[@cla=
ss=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Bitbake variables informati=
on is not loading properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Bit=
bake variables tab available&#39;)<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1516)<br>
=C2=A0 =C2=A0 =C2=A0def test_review_configuration_information(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_URL=3Dself.get_URL()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(self.element_exis=
ts(&#39;#machine-section&#39;),&#39;Machine section for the project configu=
ration page does not exist&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;q=
emux86&quot;,self.driver.find_element_by_xpath(&quot;//span[@id=3D&#39;proj=
ect-machine-name&#39;]&quot;).text),&#39;The machine type is not assigned&#=
39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//span[@id=3D&#39;change-machine-toggle&#39;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;q=
emux86&quot;,self.driver.find_element(By.XPATH, &quot;//span[@id=3D&#39;pro=
ject-machine-name&#39;]&quot;).text),&#39;The machine type is not assigned&=
#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//span[@id=3D&#39;change-machine-toggle&#39;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_until_visible(&#39;#sel=
ect-machine-form&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.wait_until_visible(&#39;#can=
cel-machine-change&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//form[@id=3D&#39;select-machine-form&#39;]/a[@id=3D&#39;cancel-mach=
ine-change&#39;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//form[@id=3D&#39;select-machine-form&#39;]/a[@id=3D&#39;cancel-mac=
hine-change&#39;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(msg=3D&#39;The machine =
information is wrong in the configuration page&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_id(&#=
39;no-most-built&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.ID, &=
#39;no-most-built&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(msg=3D&#39;No Most buil=
t information in project detail page&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;Y=
octo Project master&quot;,self.driver.find_element_by_xpath(&quot;//span[@i=
d=3D&#39;project-release-title&#39;]&quot;).text),&#39;The project release =
is not defined&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;Y=
octo Project master&quot;,self.driver.find_element(By.XPATH, &quot;//span[@=
id=3D&#39;project-release-title&#39;]&quot;).text),&#39;The project release=
 is not defined&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.fail(msg=3D&#39;No project r=
elease title information in project detail page&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//div[@id=3D&#39;layer-container&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;3=
&quot;,self.driver.find_element_by_id(&quot;project-layers-count&quot;).tex=
t),&#39;There should be 3 layers listed in the layer count&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_list =3D self.driver.find_e=
lement_by_id(&quot;layers-in-project-list&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layers =3D layer_list.find_elemen=
ts_by_tag_name(&quot;li&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//div[@id=3D&#39;layer-container&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;3=
&quot;,self.driver.find_element(By.ID, &quot;project-layers-count&quot;).te=
xt),&#39;There should be 3 layers listed in the layer count&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_list =3D self.driver.find_e=
lement(By.ID, &quot;layers-in-project-list&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layers =3D layer_list.find_elemen=
ts(By.TAG_NAME, &quot;li&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for layer in layers:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match (&quot;=
openembedded-core&quot;,layer.text):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0print (&quot;openembedded-core layer is a default layer in the project c=
onfiguration&quot;)<br>
@@ -121,60 +122,61 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):=
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1517)<br>
=C2=A0 =C2=A0 =C2=A0def test_verify_machine_information(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(self.elemen=
t_exists(&#39;#machine-section&#39;),&#39;Machine section for the project c=
onfiguration page does not exist&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
qemux86&quot;,self.driver.find_element_by_id(&quot;project-machine-name&quo=
t;).text),&#39;The machine type is not assigned&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&=
quot;change-machine-toggle&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
qemux86&quot;,self.driver.find_element(By.ID, &quot;project-machine-name&qu=
ot;).text),&#39;The machine type is not assigned&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, =
&quot;change-machine-toggle&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#3=
9;#select-machine-form&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#3=
9;#cancel-machine-change&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_id(&=
quot;cancel-machine-change&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.ID, =
&quot;cancel-machine-change&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;The ma=
chine information is wrong in the configuration page&#39;)<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1518)<br>
=C2=A0 =C2=A0 =C2=A0def test_verify_most_built_recipes_information(self):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_URL=3Dself.get_URL()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
You haven&#39;t built any recipes yet&quot;,self.driver.find_element_by_id(=
&quot;no-most-built&quot;).text),&#39;Default message of no builds is not p=
resent&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//div[@id=3D&#39;no-most-built&#39;]/p/a[@href=3D&quot;+&#39;&quot;=
&#39;+project_URL+&#39;images/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible image recipes&quot;,self.driver.find_element_by_xpath(&quot;//di=
v[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Choose a recipe to bu=
ild link=C2=A0 is not working=C2=A0 properly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
You haven&#39;t built any recipes yet&quot;,self.driver.find_element(By.ID,=
 &quot;no-most-built&quot;).text),&#39;Default message of no builds is not =
present&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//div[@id=3D&#39;no-most-built&#39;]/p/a[@href=3D&quot;+&#39;&quot=
;&#39;+project_URL+&#39;images/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Compatible image recipes&quot;,self.driver.find_element(By.XPATH, &quot;//d=
iv[@class=3D&#39;col-md-10&#39;]&quot;).text),&#39;The Choose a recipe to b=
uild link=C2=A0 is not working=C2=A0 properly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Mos=
t built information in project detail page&#39;)<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1519)<br>
=C2=A0 =C2=A0 =C2=A0def test_verify_project_release_information(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Yocto Project master&quot;,self.driver.find_element_by_id(&quot;project-rel=
ease-title&quot;).text),&#39;The project release is not defined&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Yocto Project master&quot;,self.driver.find_element(By.ID, &quot;project-re=
lease-title&quot;).text),&#39;The project release is not defined&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No pro=
ject release title information in project detail page&#39;)<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1520)<br>
=C2=A0 =C2=A0 =C2=A0def test_verify_layer_information(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_URL=3Dself.get_URL()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//div[@id=3D&#39;layer-container&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;3=
&quot;,self.driver.find_element_by_id(&quot;project-layers-count&quot;).tex=
t),&#39;There should be 3 layers listed in the layer count&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_list =3D self.driver.find_e=
lement_by_id(&quot;layers-in-project-list&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layers =3D layer_list.find_elemen=
ts_by_tag_name(&quot;li&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//div[@id=3D&#39;layer-container&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(re.search(&quot;3=
&quot;,self.driver.find_element(By.ID, &quot;project-layers-count&quot;).te=
xt),&#39;There should be 3 layers listed in the layer count&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layer_list =3D self.driver.find_e=
lement(By.ID, &quot;layers-in-project-list&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0layers =3D layer_list.find_elemen=
t(By.TAG_NAME, &quot;li&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for layer in layers:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if re.match (&quot;=
openembedded-core&quot;,layer.text):<br>
@@ -186,43 +188,43 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.f=
ail(msg=3D&#39;default layers are missing from the project configuration&#3=
9;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//input[@id=3D&#39;layer-add-input&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//button[@id=3D&#39;add-layer-btn&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//div[@id=3D&#39;layer-container&#39;]/form[@class=3D&#39;form-inlin=
e&#39;]/p/a[@id=3D&#39;view-compatible-layers&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element_by_xpath=
(&quot;//div[@id=3D&#39;layer-container&#39;]/form[@class=3D&#39;form-inlin=
e&#39;]/p/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;importlayer&qu=
ot;&#39;+&quot;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//input[@id=3D&#39;layer-add-input&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//button[@id=3D&#39;add-layer-btn&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//div[@id=3D&#39;layer-container&#39;]/form[@class=3D&#39;form-inli=
ne&#39;]/p/a[@id=3D&#39;view-compatible-layers&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.driver.find_element(By.XPATH=
, &quot;//div[@id=3D&#39;layer-container&#39;]/form[@class=3D&#39;form-inli=
ne&#39;]/p/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;importlayer&q=
uot;&#39;+&quot;]&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;No Lay=
er information in project detail page&#39;)<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1521)<br>
=C2=A0 =C2=A0 =C2=A0def test_verify_project_detail_links(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(&#39;&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/t=
oastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;global-nav&#39;]/ul/li/a[@href=3D&quot;+&#39;&quot;&#39;+&#39;/=
toastergui/projects/&#39;+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.wait_until_visible(&#39;#projectstab=
le&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.find_element_by_link_text_in_table(&=
#39;projectstable&#39;, &#39;selenium-project&#39;).click()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_URL=3Dself.get_URL()<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpath(&quot;//div[=
@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li[@id=
=3D&#39;topbar-configuration-tab&#39;]/a[@href=3D&quot;+&#39;&quot;&#39;+pr=
oject_URL+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;Configuration&=
quot;,self.driver.find_element_by_xpath(&quot;//div[@id=3D&#39;project-topb=
ar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li[@id=3D&#39;topbar-configura=
tion-tab&#39;]/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;&quot;&#3=
9;+&quot;]&quot;).text), &#39;Configuration tab in project topbar is misspe=
lled&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPATH, &quot;//div=
[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li[@id=
=3D&#39;topbar-configuration-tab&#39;]/a[@href=3D&quot;+&#39;&quot;&#39;+pr=
oject_URL+&#39;&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;Configuration&=
quot;,self.driver.find_element(By.XPATH, &quot;//div[@id=3D&#39;project-top=
bar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li[@id=3D&#39;topbar-configur=
ation-tab&#39;]/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;&quot;&#=
39;+&quot;]&quot;).text), &#39;Configuration tab in project topbar is missp=
elled&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs=
&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;builds/&quot;&=
#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Builds&quot;,self.driver.find_element_by_xpath(&quot;//div[@id=3D&#39;proje=
ct-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=3D&quot;+&#3=
9;&quot;&#39;+project_URL+&#39;builds/&quot;&#39;+&quot;]&quot;).text), &#3=
9;Builds tab in project topbar is misspelled&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//div[@id=3D&#39;empty-state-projectbuildstable&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tab=
s&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;builds/&quot;=
&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Builds&quot;,self.driver.find_element(By.XPATH, &quot;//div[@id=3D&#39;proj=
ect-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=3D&quot;+&#=
39;&quot;&#39;+project_URL+&#39;builds/&quot;&#39;+&quot;]&quot;).text), &#=
39;Builds tab in project topbar is misspelled&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//div[@id=3D&#39;empty-state-projectbuildstable&#39;]&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;Builds=
 tab information is not present&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs=
&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;importlayer&qu=
ot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Import layer&quot;,self.driver.find_element_by_xpath(&quot;//div[@id=3D&#39=
;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=3D&quo=
t;+&#39;&quot;&#39;+project_URL+&#39;importlayer&quot;&#39;+&quot;]&quot;).=
text), &#39;Import layer tab in project topbar is misspelled&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//fieldset[@id=3D&#39;repo-select&#39;]&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//fieldset[@id=3D&#39;git-repo&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tab=
s&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;importlayer&q=
uot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Import layer&quot;,self.driver.find_element(By.XPATH, &quot;//div[@id=3D&#3=
9;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=3D&qu=
ot;+&#39;&quot;&#39;+project_URL+&#39;importlayer&quot;&#39;+&quot;]&quot;)=
.text), &#39;Import layer tab in project topbar is misspelled&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//fieldset[@id=3D&#39;repo-select&#39;]&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//fieldset[@id=3D&#39;git-repo&#39;]&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;Import=
 layer tab not loading properly&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element_by_xpat=
h(&quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs=
&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;newcustomimage=
/&quot;&#39;+&quot;]&quot;).click()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
New custom image&quot;,self.driver.find_element_by_xpath(&quot;//div[@id=3D=
&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=3D=
&quot;+&#39;&quot;&#39;+project_URL+&#39;newcustomimage/&quot;&#39;+&quot;]=
&quot;).text), &#39;New custom image tab in project topbar is misspelled&#3=
9;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Select the image recipe you want to customise&quot;,self.driver.find_elemen=
t_by_xpath(&quot;//div[@class=3D&#39;col-md-12&#39;]/h2&quot;).text),&#39;T=
he new custom image tab is not loading correctly&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.driver.find_element(By.XPAT=
H, &quot;//div[@id=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tab=
s&#39;]/li/a[@href=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;newcustomimag=
e/&quot;&#39;+&quot;]&quot;).click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
New custom image&quot;,self.driver.find_element(By.XPATH, &quot;//div[@id=
=3D&#39;project-topbar&#39;]/ul[@class=3D&#39;nav nav-tabs&#39;]/li/a[@href=
=3D&quot;+&#39;&quot;&#39;+project_URL+&#39;newcustomimage/&quot;&#39;+&quo=
t;]&quot;).text), &#39;New custom image tab in project topbar is misspelled=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(re.search(&quot;=
Select the image recipe you want to customise&quot;,self.driver.find_elemen=
t(By.XPATH, &quot;//div[@class=3D&#39;col-md-12&#39;]/h2&quot;).text),&#39;=
The new custom image tab is not loading correctly&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fail(msg=3D&#39;New cu=
stom image tab not loading properly&#39;)<br>
<br>
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster=
/tests/toaster-tests-requirements.txt<br>
index 4f9fcc46..f30ac070 100644<br>
--- a/lib/toaster/tests/toaster-tests-requirements.txt<br>
+++ b/lib/toaster/tests/toaster-tests-requirements.txt<br>
@@ -1 +1 @@<br>
-selenium=3D=3D2.49.2<br>
+selenium&gt;=3D4.13.0<br>
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/view=
s/test_views.py<br>
index 735d596b..f962e762 100644<br>
--- a/lib/toaster/tests/views/test_views.py<br>
+++ b/lib/toaster/tests/views/test_views.py<br>
@@ -19,6 +19,7 @@ from orm.models import Layer_Version, Recipe<br>
=C2=A0from orm.models import CustomImageRecipe<br>
=C2=A0from orm.models import CustomImagePackage<br>
<br>
+from bldcontrol.models import BuildEnvironment<br>
=C2=A0import inspect<br>
=C2=A0import toastergui<br>
<br>
@@ -45,6 +46,9 @@ class ViewTests(TestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.cust_package =3D CustomImagePackage.=
objects.first()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.package =3D Package.objects.first()<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.lver =3D Layer_Version.objects.first=
()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if BuildEnvironment.objects.count() =3D=3D 0:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BuildEnvironment.objects.create(=
betype=3DBuildEnvironment.TYPE_LOCAL)<br>
+<br>
<br>
=C2=A0 =C2=A0 =C2=A0def test_get_base_call_returns_html(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Basic test for all-proj=
ects view&quot;&quot;&quot;<br>
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/wid=
gets.py<br>
index 53696912..6e87285c 100644<br>
--- a/lib/toaster/toastergui/widgets.py<br>
+++ b/lib/toaster/toastergui/widgets.py<br>
@@ -305,6 +305,7 @@ class ToasterTable(TemplateView):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.setup_columns(**kwargs)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.apply_orderby(&#39;pk&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if search:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.apply_search(search)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if filters:<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15177): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15177" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15177</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101738649/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/101738649/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000b8da9406077cf5f9--

