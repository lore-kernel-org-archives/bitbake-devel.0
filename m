Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id AA1A679DAE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Nov 2018 12:54:35 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id B7C885C02D9;
	Wed,  7 Nov 2018 13:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1541595275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=/Gci0dUiyeDf3iHTJqPZlulHN87K189KYxctMPis34U=;
	b=H3lY6of6I22n3RrfWXvGOSqy78UF/AFjR5e5vjbfA1OA6Ss2Qqlp0IkVT388qBcZIAQrnk
	IwPqOOtSmhnXKzZk9azG8KTm/6vTET6TbG2V0HZeEz8A+0GpArQzF+pfiDSS+p23HrMAOP
	K9zPrgbeo4uxo2+RWtlROWeXBRSIbYc=
MIME-Version: 1.0
Date: Wed, 07 Nov 2018 13:54:35 +0100
From: Stefan Agner <stefan@agner.ch>
To: Mark Hatle <mark.hatle@windriver.com>
In-Reply-To: <20181031192144.35366-2-mark.hatle@windriver.com>
References: <20181031192144.35366-1-mark.hatle@windriver.com>
	<20181031192144.35366-2-mark.hatle@windriver.com>
Message-ID: <46362598864dece1b1e927bc7b30493e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] fetch2/gitsm.py: Disable branch checking on submodules
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
X-List-Received-Date: Wed, 07 Nov 2018 12:54:35 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 31.10.2018 20:21, Mark Hatle wrote:
> Submodules by definition refer to a specific commit, not branch.  If we don't
> ignore the branch, then any commits on a submodule on a branch different then
> the original module will trigger a failure that the commit is not on the
> branch.
> 
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>

Thanks Mark, this seems to also fix the regression I mentioned a couple
of days ago:
http://lists.openembedded.org/pipermail/bitbake-devel/2018-October/009691.html

Tested-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  lib/bb/fetch2/gitsm.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 0a982da..dbfa3a4 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -92,7 +92,7 @@ class GitSM(Git):
>              url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
>              url += ';protocol=%s' % proto
>              url += ";name=%s" % module
> -            url += ";bareclone=1;nocheckout=1"
> +            url += ";bareclone=1;nocheckout=1;nobranch=1"
>  
>              ld = d.createCopy()
>              # Not necessary to set SRC_URI, since we're passing the URI to
> -- 
> 1.8.3.1

