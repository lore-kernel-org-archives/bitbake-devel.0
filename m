Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDCEC4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 18:25:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.3352.1698776708332984401
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 11:25:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=elTrCZaA;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 597F99C2929;
	Tue, 31 Oct 2023 14:25:07 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id d-oK6FfeFfWs; Tue, 31 Oct 2023 14:25:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 874829C296C;
	Tue, 31 Oct 2023 14:25:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 874829C296C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698776706; bh=h/Pwu21a2USA/c9089Zo3Jfxn84+eHpLxfZwqI4VQDA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=elTrCZaAuzRGtk9zD07JNeTyK07pwd6ymwBqQdBRJ7IyL8TQgPMl3qOx//CXUYfkq
	 xxwn7BeB/1n2WrD4qxed6ABSFcKnBGhj/oj3uuVoPrHUU3/YFTyEhtWXMZb38wpEBZ
	 YjQ+9pW2p71F5ir3Y2nGgcB/pWUuNksGirs8EKUVn3A+5y+IH49X2lVbkjUMcv12RS
	 fqigjQ44cfOBXQ703jRX1RMmrwOsM9ZG3tJKWRV+WdkPjmCEKZSmnlyT4ixEH9BeHs
	 4qAoJ+Gt0dqTozEP1r5gXSGI/lxeZfFIli3d3NjKDC8tfBhHa6/xtop8Jfh1FCIUEh
	 fJSpEZOJ2H2mw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id SBZ43bdbYhnL; Tue, 31 Oct 2023 14:25:06 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6C6979C2929;
	Tue, 31 Oct 2023 14:25:06 -0400 (EDT)
Date: Tue, 31 Oct 2023 14:25:06 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Tim Orling <ticotimo@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	toaster <toaster@lists.yoctoproject.org>
Message-ID: <1096769885.300473.1698776706378.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <CANx9H-CjFsyKpJ-HtLVJnozJhxM4D2==nWX=Yzo2_rsQgPvmzw@mail.gmail.com>
References: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com> <CANx9H-CjFsyKpJ-HtLVJnozJhxM4D2==nWX=Yzo2_rsQgPvmzw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] Toaster: Check info_sign is visible
 and clickable in landing page
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_4570)
Thread-Topic: Toaster: Check info_sign is visible and clickable in landing page
Thread-Index: HfJWW33npYilso8P3dkGPSiTosk6IA==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 18:25:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15378

Tim,

> This import is unused in this commit. Also, in general we want to avoidte=
sts that rely on specific timing anyway.
Yes, i already created a [patch 4/4] to delete this import.
https://lists.yoctoproject.org/g/toaster/topic/patch_4_4_toaster_remove/102=
297871?p=3D,,,20,0,0,0::recentpostdate/sticky,,,20,2,0,102297871,previd%3D1=
698774201827565394,nextid%3D1698695506149157438&previd=3D169877420182756539=
4&nextid=3D1698695506149157438  =20

----- Mail original -----
De: "Tim Orling" <ticotimo@gmail.com>
=C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>, "toaster" <toas=
ter@lists.yoctoproject.org>
Envoy=C3=A9: Mardi 31 Octobre 2023 16:28:57
Objet: Re: [bitbake-devel] [PATCH 1/3] Toaster: Check info_sign is visible =
and clickable in landing page

On Mon, Oct 30, 2023 at 3:26=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Check the information icon is visible and clickable
> Also if popup appearing when clicked and contain "Toaster version
> information"
>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/browser/test_landing_page.py | 17 +++++++++++++++++
>  lib/toaster/toastergui/templates/base.html     |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/lib/toaster/tests/browser/test_landing_page.py
> b/lib/toaster/tests/browser/test_landing_page.py
> index 8bb64b9f..2f092400 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -7,6 +7,7 @@
>  # Copyright (C) 2013-2016 Intel Corporation
>  #
>
> +from time import sleep
>

This import is unused in this commit. Also, in general we want to avoid
tests that rely on specific timing anyway.


>  from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
> @@ -29,6 +30,22 @@ class TestLandingPage(SeleniumTestCase):
>          self.project.is_default =3D True
>          self.project.save()
>
>
The test case itself seems reasonable.


> +    def test_icon_info_visible_and_clickable(self):
> +        """ Test that the information icon is visible and clickable """
> +        self.get(reverse('landing'))
> +        info_sign =3D self.find('#toaster-version-info-sign')
> +
> +        # check that the info sign is visible
> +        self.assertTrue(info_sign.is_displayed())
> +
> +        # check that the info sign is clickable
> +        # and info modal is appearing when clicking on the info sign
> +        info_sign.click() # click on the info sign make attribute
> 'aria-describedby' visible
> +        info_model_id =3D info_sign.get_attribute('aria-describedby')
> +        info_modal =3D self.find(f'#{info_model_id}')
> +        self.assertTrue(info_modal.is_displayed())
> +        self.assertTrue("Toaster version information" in info_modal.text=
)
> +
>      def test_only_default_project(self):
>          """
>          No projects except default
> diff --git a/lib/toaster/toastergui/templates/base.html
> b/lib/toaster/toastergui/templates/base.html
> index e8600f3e..041448d1 100644
> --- a/lib/toaster/toastergui/templates/base.html
> +++ b/lib/toaster/toastergui/templates/base.html
> @@ -94,7 +94,7 @@
>              </a>
>              <a class=3D"brand" href=3D"/">Toaster</a>
>              {% if DEBUG %}
> -            <span class=3D"glyphicon glyphicon-info-sign"
> title=3D"<strong>Toaster version information</strong>"
> data-content=3D"<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git
> revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
> +            <span id=3D"toaster-version-info-sign" class=3D"glyphicon
> glyphicon-info-sign" title=3D"<strong>Toaster version information</strong=
>"
> data-content=3D"<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git
> revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>">


Adding an id for the span is very helpful for both testing and using e.g.
Developer Tools in Chromium or Firefox. Good idea.


> </i>
>              {% endif %}
>            </div>
>          </div>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15333):
> https://lists.openembedded.org/g/bitbake-devel/message/15333
> Mute This Topic: https://lists.openembedded.org/mt/102286644/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

