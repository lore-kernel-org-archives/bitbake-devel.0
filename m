Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com
	[209.85.213.177])
	by mail.openembedded.org (Postfix) with ESMTP id 8AE1F60053
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:05:02 +0000 (UTC)
Received: by igcpb10 with SMTP id pb10so25131006igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=CRTo/Z8P/XZ+IzlVnA8t+XOynCRqUqMitC1rM0dTWQQ=;
	b=K8XeabXJ/w6ARw4o05ikvhCPplVBHPTikmkaqcBRvwt0ZnmUm5Ysz/gvXvMMh4gFZb
	Dp0kDmWTTC9IzS+fRhtWCnvEZy7TY3OHZ+0fMGJSkJ0OQqOyn1f0/oWe940kb/HwSD8i
	M5yGIXg3jg9G3qvWgFrmqFbIrkkhj6UQiOUIaGVKmCKu4iABfvqbeTm4oIxus4c0H+LJ
	YFRlfvqWAgOlEwZwnBmLgvp38nkGQhVOqPLQPxjJ3nvwOx29nShTIBG9lBms0y0D7UdS
	27dmTFXdBflvqDNACAmB01+oaI6kr5MKIOhDYxVXxUT9gW++b8qzegWBaf8zkrRezQLS
	htAw==
MIME-Version: 1.0
X-Received: by 10.50.27.102 with SMTP id s6mr7984487igg.23.1441904702973; Thu,
	10 Sep 2015 10:05:02 -0700 (PDT)
Received: by 10.64.55.39 with HTTP; Thu, 10 Sep 2015 10:05:02 -0700 (PDT)
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Date: Thu, 10 Sep 2015 10:05:02 -0700
Message-ID: <CAKV_0eiR791w4ZVC4hG1p14X5WmiaoRZuRjSFU+NCtu+den3jg@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/5] Hide irrelevant builds
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
X-List-Received-Date: Thu, 10 Sep 2015 17:05:05 -0000
Content-Type: text/plain; charset=UTF-8

submitted upstream.
-b

On Thu, Sep 10, 2015 at 10:05 AM, brian avery <avery.brian@gmail.com> wrote:
> This patch fixes the project builds view so it doesn't show
> "in progress" builds or builds for other projects.
>
> The following changes since commit db92bc23880794be77373b0f2d8c26279dcecb84:
>
>   bitbake: toaster: replace ETA with % of tasks done (2015-09-08 23:54:15 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/20150902_hide_irrelevant_builds_v2
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/20150902_hide_irrelevant_builds_v2
>
> Alexandru DAMIAN (1):
>   toaster: hide irrelevant builds in the project builds view
>
> Elliot Smith (4):
>   toaster: Add tests for /project/X/builds page
>   toaster: Show correct builds count on project pages
>   toaster: Fix date range pickers on the project builds page
>   toaster: Simplify redirects when build page parameters are missing
>
>  lib/toaster/toastergui/static/js/base.js           |   4 +-
>  .../toastergui/templates/projectbuilds.html        |   4 +-
>  lib/toaster/toastergui/tests.py                    |  91 ++++++++++++++++-
>  lib/toaster/toastergui/views.py                    | 108 +++++++++++++++------
>  toaster-requirements.txt                           |   1 +
>  5 files changed, 169 insertions(+), 39 deletions(-)
>
> --
> 1.9.1
>

