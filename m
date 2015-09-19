Return-Path: <raj.khem@gmail.com>
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com
	[209.85.223.174])
	by mail.openembedded.org (Postfix) with ESMTP id AFE2C7680E
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 21:10:40 +0000 (UTC)
Received: by ioii196 with SMTP id i196so87899244ioi.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=A2BYmLuVAI7YtK04GrOgptieTSxP562GgF3KaNPm15A=;
	b=ZFA97O7I36X35StHASPCEgTEK1AQRtBvCXqaOR+wTtiTEcZ/VC4rF3v/eDR+D0pGxn
	pwAim/74u2FWTRAX6uZO+ROm8uScJh7f3FcWBtqkRFvBrDFf2lCou8LFBqQjQNt671tZ
	2+bwUfg5O1eXT6v+97MyNpkOPMyLP3pITr5XB4N/FMjSFzfe1pi1Z0jg5vy6erezML+b
	5ZrxOAZGyUV6I7Dn1CRMeVSmUz94d/WFZxSZBIpaplO4SS0443OuLK06Tjlv/mdWXz94
	dZMGSBfHL2DL8DiA5HM7z+PRHzQn+8xjRbD6chzQ2MndZufJeitA3pn5K9nEmiJ5pfN/
	Tihw==
X-Received: by 10.107.137.106 with SMTP id l103mr19652606iod.112.1442697040872;
	Sat, 19 Sep 2015 14:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.142.130 with HTTP; Sat, 19 Sep 2015 14:10:11 -0700 (PDT)
In-Reply-To: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
References: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Sat, 19 Sep 2015 14:10:11 -0700
Message-ID: <CAMKF1sri5kt4-JxXDttLWOHCHmrsR6QF7MXANsU3W=08eHbUAQ@mail.gmail.com>
To: Romain Perier <romain.perier@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Sat, 19 Sep 2015 21:10:43 -0000
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 18, 2015 at 9:35 AM, Romain Perier <romain.perier@gmail.com> wrote:
> Currently this module is dereferencing errno.ENOENT but the python module "errno"
> is not imported, which causes a crash when fetching from a git repository.
>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 4a32a31..9bd87ad 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -66,6 +66,7 @@ Supported SRC_URI options are:
>  # with this program; if not, write to the Free Software Foundation, Inc.,
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>
> +import errno
>  import os
>  import re
>  import bb

this patch is against poky repo, please rebase it against bitbake repo
and resend. Its breaking all my builds currently.

