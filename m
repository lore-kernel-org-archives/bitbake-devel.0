Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AAFC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 08:09:53 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.23479.1699603787428319454
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 00:09:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RhS1KEJH;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 48B90240008;
	Fri, 10 Nov 2023 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699603784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMiL6evzuf2XZl/htYpK6tXvNPtYJDIQtDRsKZRR76o=;
	b=RhS1KEJHQDEbO0fs+Zp1ig1vBcN3i/IQDmQW6MHGtrCRhvoBU8VsdfI8bPdKENBEaDTScw
	eSTFEyMgGNCQEeLl63ZQxUSKfEYuBec5H5Yuls5mzGLL3tau8NZg7Enk7WbuTSPLCN1o8B
	hGwt6gSKAk+Oj9ZPBVJw0Yc5AbAa2JUvSX1+pdXD6twviX/J3fc0ctynswS81XJBS1DBWP
	NAVKwp0IT/L7ratQLNS+usDc/W86bGQ4AOQrUJcbLBGAgyMXhbxluvYTPT4pf20faKkNdz
	K5/R11TQHrTvkEufrtbOnCOYwDuRa3T3gHAzX/GF134/2P2gZIzRLBY/NQn9lQ==
Date: Fri, 10 Nov 2023 09:09:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v3 1/3] Toaster: Write UI TestCase create
 new project
Message-ID: <20231110080943ba6dd2d1@mail.local>
References: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 08:09:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15490

Hello Alassane,

On 09/11/2023 23:15:15+0100, Alassane Yattara wrote:
> Test create new project using:
> - Project Name: Any string
> - Release: Master/Kirkstone/Dunfell/Local
> - Merge Toaster settings: False/True
> 
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---

Please include a changelog here. At least, explain why you are sending
multiple versions of the series on the same day, this would make the
maintainers job easier.

Thanks!

>  .../functional/test_create_new_project.py     | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 lib/toaster/tests/functional/test_create_new_project.py
> 
> diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
> new file mode 100644
> index 00000000..81355eaf
> --- /dev/null
> +++ b/lib/toaster/tests/functional/test_create_new_project.py
> @@ -0,0 +1,134 @@
> +#! /usr/bin/env python3 #
> +# BitBake Toaster UI tests implementation
> +#
> +# Copyright (C) 2023 Savoir-faire Linux
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import re
> +import pytest
> +from django.urls import reverse
> +from selenium.webdriver.support.ui import Select
> +from tests.functional.functional_helpers import SeleniumFunctionalTestCase
> +from orm.models import Project
> +from selenium.webdriver.common.by import By
> +
> +@pytest.mark.django_db
> +class TestCreateNewProject(SeleniumFunctionalTestCase):
> +
> +    def _create_test_new_project(
> +        self,
> +        project_name,
> +        release,
> +        release_title,
> +        merge_toaster_settings,
> +    ):
> +        """ Create/Test new project using:
> +          - Project Name: Any string
> +          - Release: Any string
> +          - Merge Toaster settings: True or False
> +        """
> +        self.get(reverse('newproject'))
> +        self.driver.find_element(By.ID,
> +                                 "new-project-name").send_keys(project_name)
> +
> +        select = Select(self.find('#projectversion'))
> +        select.select_by_value(release)
> +
> +        # check merge toaster settings
> +        checkbox = self.find('.checkbox-mergeattr')
> +        if merge_toaster_settings:
> +            if not checkbox.is_selected():
> +                checkbox.click()
> +        else:
> +            if checkbox.is_selected():
> +                checkbox.click()
> +
> +        self.driver.find_element(By.ID, "create-project-button").click()
> +
> +        element = self.wait_until_visible('#project-created-notification')
> +        self.assertTrue(
> +            self.element_exists('#project-created-notification'), 
> +            f"Project:{project_name} creation notification not shown"
> +        )
> +        self.assertTrue(
> +            project_name in element.text,
> +            f"New project name:{project_name} not in new project notification"
> +        )
> +        self.assertTrue(
> +            Project.objects.filter(name=project_name).count(), 
> +            f"New project:{project_name} not found in database"
> +        )
> +
> +        # check release
> +        self.assertTrue(re.search(
> +            release_title,
> +            self.driver.find_element(By.XPATH,
> +                                     "//span[@id='project-release-title']"
> +                                     ).text),
> +                        'The project release is not defined')
> +
> +    def test_create_new_project_master(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project master (option value: 3)
> +          - Merge Toaster settings: False
> +        """
> +        release = '3'
> +        release_title = 'Yocto Project master'
> +        project_name = 'projectmaster'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            False,
> +        )
> +
> +    def test_create_new_project_kirkstone(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
> +          - Merge Toaster settings: True
> +        """
> +        release = '1'
> +        release_title = 'Yocto Project 4.0 "Kirkstone"'
> +        project_name = 'projectkirkstone'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            True,
> +        )
> +
> +    def test_create_new_project_dunfull(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
> +          - Merge Toaster settings: False
> +        """
> +        release = '5'
> +        release_title = 'Yocto Project 3.1 "Dunfell"'
> +        project_name = 'projectdunfull'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            False,
> +        )
> +    
> +    def test_create_new_project_local(self):
> +        """ Test create new project using:
> +          - Project Name: Any string
> +          - Release: Local Yocto Project (option value: 2)
> +          - Merge Toaster settings: True
> +        """
> +        release = '2'
> +        release_title = 'Local Yocto Project'
> +        project_name = 'projectlocal'
> +        self._create_test_new_project(
> +            project_name,
> +            release,
> +            release_title,
> +            True,
> +        )
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15487): https://lists.openembedded.org/g/bitbake-devel/message/15487
> Mute This Topic: https://lists.openembedded.org/mt/102496102/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

