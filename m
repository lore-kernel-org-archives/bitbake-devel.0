Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B97BC4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 14:42:58 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.32658.1698936176694883254
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 07:42:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bnfmjkiC;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AC57E0005;
	Thu,  2 Nov 2023 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1698936174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mJQFNnrreOMs2QyZaATdw9crfpLnSg0PTz3tS737y5I=;
	b=bnfmjkiCcMpGmw8KcFIx+jCv/HunvY3X2dys0g5LkgElrlokb1Q0evwsszcgYkCZIKdY7Z
	dklJM+Xw1cNz9lDl9uJ9LRxLarQLU2/rsA6vZs5ew8d7b2n/Wz1SIsm9JmSDL0ncfoBar/
	QZkVbx50rXosSS8hH2GF8tkNO+RYftQaS3/GQsLBDpAiVKGp29JWuQ0Uhkr/Ih7tF1DjIO
	YUfQLNC74qhq2QnOdEEfyrj26fUa75AeFR+9tKN+ibY+UunEKmfvr2UuJ0vJMksSnsrcSx
	NKDISyq4tQJVYYXsJ6JsfPLb4YjHeAu7u0W30vSq1TGgiR1sns7ktnd9Tv4bog==
Date: Thu, 2 Nov 2023 15:42:53 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>,
	Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2 3/3] Toaster: Test jumbotron links
 visible and clickable
Message-ID: <20231102144253276e56a8@mail.local>
References: <20231031184438.743924-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031184438.743924-1-alassane.yattara@savoirfairelinux.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 14:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15413

Hello,

I'm sorry, I have a hard time finding what to apply and in which order.

For example, this patch was sent alone and doesn't apply on master:

Alassane Yattara   31/10/23 15:20 [bitbake-devel] [PATCH 4/4] Toaster: Remove unused sleep import from time

This one was also sent alone:

Alassane Yattara   31/10/23 19:44 [bitbake-devel] [PATCH v2 3/3] Toaster: Test jumbotron links visible and clickable

While I could go and try to find the series it is part of, this imposes
work on the maintainer.

Can you make sure you send full series that apply on master or
master-next every time?


Also if series are depending on each other, then, this should be only
one series or you should probably wait for the first series to be
applied.

Maybe you could provide a bitbake branch so I can know what you expect
to be merged? If you do so, please ensure the content of the branch is
exactly what you sent on the list. Ideally, you would collect review
tags.

Thanks!

On 31/10/2023 19:44:38+0100, Alassane Yattara wrote:
> Test that the followings link are visible and clickable:
>  - OpenEmbedded
>  - BitBake
>  - Yocto Project
>  - Read the Toaster manual
>  - Contribute to Toaster
> 
>  - Fixed typo: using instead of usign line:97
>  - Remove whitespace
> 
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/browser/test_landing_page.py        | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
> index e731af22..756497bd 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -12,7 +12,7 @@ from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
>  
> -from orm.models import Project, Build
> +from orm.models import Layer, Layer_Version, Project, Build
>  
>  class TestLandingPage(SeleniumTestCase):
>      """ Tests for redirects on the landing page """
> @@ -61,6 +61,93 @@ class TestLandingPage(SeleniumTestCase):
>              'http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual')
>          self.assertTrue("Documentation" in documentation_link.text)
>  
> +    def test_openembedded_jumbotron_link_visible_and_clickable(self):
> +        """ Test OpenEmbedded link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check OpenEmbedded
> +        openembedded = jumbotron.find_element_by_link_text('OpenEmbedded')
> +        self.assertTrue(openembedded.is_displayed())
> +        openembedded.click()
> +        self.assertTrue("openembedded.org" in self.driver.current_url)
> +
> +    def test_bitbake_jumbotron_link_visible_and_clickable(self):
> +        """ Test BitBake link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check BitBake
> +        bitbake = jumbotron.find_element_by_link_text('BitBake')
> +        self.assertTrue(bitbake.is_displayed())
> +        bitbake.click()
> +        self.assertTrue("yoctoproject.org/software-item/bitbake" in self.driver.current_url)
> +
> +    def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
> +        """ Test Yocto Project link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check Yocto Project
> +        yoctoproject = jumbotron.find_element_by_link_text('Yocto Project')
> +        self.assertTrue(yoctoproject.is_displayed())
> +        yoctoproject.click()
> +        self.assertTrue("yoctoproject.org" in self.driver.current_url)
> +
> +    def test_link_setup_using_toaster_visible_and_clickable(self):
> +        """ Test big magenta button setting up and using toaster link in jumbotron
> +            if visible and clickable
> +        """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check Big magenta button
> +        big_magenta_button = jumbotron.find_element_by_link_text(
> +            'Toaster is ready to capture your command line builds'
> +        )
> +        self.assertTrue(big_magenta_button.is_displayed())
> +        big_magenta_button.click()
> +        self.assertTrue("docs.yoctoproject.org/toaster-manual/setup-and-use.html#setting-up-and-using-toaster" in self.driver.current_url)
> +
> +    def test_link_create_new_project_in_jumbotron_visible_and_clickable(self):
> +        """ Test big blue button create new project jumbotron if visible and clickable """
> +        # Create a layer and a layer version to make visible the big blue button
> +        layer = Layer.objects.create(name='bar')
> +        Layer_Version.objects.create(layer=layer)
> +
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check Big Blue button
> +        big_blue_button = jumbotron.find_element_by_link_text(
> +            'Create your first Toaster project to run manage builds'
> +        )
> +        self.assertTrue(big_blue_button.is_displayed())
> +        big_blue_button.click()
> +        self.assertTrue("toastergui/newproject/" in self.driver.current_url)
> +
> +    def test_toaster_manual_link_visible_and_clickable(self):
> +        """ Test Read the Toaster manual link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check Read the Toaster manual
> +        toaster_manual = jumbotron.find_element_by_link_text('Read the Toaster manual')
> +        self.assertTrue(toaster_manual.is_displayed())
> +        toaster_manual.click()
> +        self.assertTrue("https://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual" in self.driver.current_url)
> +
> +    def test_contrib_to_toaster_link_visible_and_clickable(self):
> +        """ Test Contribute to Toaster link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron = self.find('.jumbotron')
> +
> +        # check Contribute to Toaster
> +        contribute_to_toaster = jumbotron.find_element_by_link_text('Contribute to Toaster')
> +        self.assertTrue(contribute_to_toaster.is_displayed())
> +        contribute_to_toaster.click()
> +        self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaster" in str(self.driver.current_url).lower())
> +
>      def test_only_default_project(self):
>          """
>          No projects except default
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15379): https://lists.openembedded.org/g/bitbake-devel/message/15379
> Mute This Topic: https://lists.openembedded.org/mt/102304202/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

