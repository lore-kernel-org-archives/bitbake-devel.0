Received: from mail-ea0-f179.google.com ([209.85.215.179])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1TsqKQ-00084D-J8
	for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jan 2013 08:44:09 +0100
Received: by mail-ea0-f179.google.com with SMTP id i12so506429eaa.24
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jan 2013 23:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:date:message-id:in-reply-to:references
	:user-agent:subject:mime-version:content-type
	:content-transfer-encoding;
	bh=XTmf57MifWMYg0X8Jg0vPwkBLq9kDmM5V2b7tcTMsns=;
	b=O80wY6pxJAh6NE8bkWqAjoZ21EclFFslgKV8mmbYOqq/1QBeO0bX+yi11gm6QEjW6W
	+mCF/sbD5/Hb7WqL33ih7I3JcyNdDI34OakRKUybYMpgBbPRsy0PrzS8wCv5VqpFz9Y1
	G5KfUhSRmDGyGZp/c3FGlcwYhUrXAK2XTMxNP2k104RXddQEcx/zQyaYh0a1TefMdL4/
	jnUootdqk6TsENDlUKz9/YwsPfX3Xa0lCKOiGOctU8Lcz4UvChCv3HrDfVMfQsM7QuAm
	KMMSOxCIODaSAZGetKFqtGXGHvVU7DNab/bOcf3yWhKaJOEaPSqLlwSoucd62Fw4Lctv
	Tf6Q==
X-Received: by 10.14.194.199 with SMTP id m47mr179438914een.11.1357716530868; 
	Tue, 08 Jan 2013 23:28:50 -0800 (PST)
Received: from [93.111.204.44] (093111204044.atmpu0047.highway.a1.net.
	[93.111.204.44])
	by mx.google.com with ESMTPS id b2sm139876636eep.9.2013.01.08.23.28.48
	(version=SSLv3 cipher=OTHER); Tue, 08 Jan 2013 23:28:49 -0800 (PST)
From: "Bernhard Reutner-Fischer" <rep.dot.nop@gmail.com>
To: Mark Hatle <mark.hatle@windriver.com>,
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 09 Jan 2013 08:30:41 +0100
Message-ID: <13c1e37c83e.2760.0f39ed3bcad52ef2c88c90062b7714dc@gmail.com>
In-Reply-To: <1357581443-27929-1-git-send-email-mark.hatle@windriver.com>
References: <1357581443-27929-1-git-send-email-mark.hatle@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:9.0) Gecko/20111222 Thunderbird/9.0.1 AquaMail/1.2.1 (build:
	2100173)
MIME-Version: 1.0
Subject: Re: [PATCH] lib/bb/build.py: 'deps' may not always exist in a few corner cases.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 09 Jan 2013 07:44:10 -0000
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 8bit

On 7 January 2013 18:57:23 Mark Hatle <mark.hatle@windriver.com> wrote:
> With a small set of recipes (1), and all system dependencies assume_provided,
> we may end up with no parent dependencies.  So we check if 'deps' was defined
> instead of always assuming it exists.
>
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/build.py |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/build.py b/lib/bb/build.py
> index 43790a6..2f6a61f 100644
> --- a/lib/bb/build.py
> +++ b/lib/bb/build.py
> @@ -591,9 +591,10 @@ def add_tasks(tasklist, d):
>          getTask('noexec')
>          getTask('umask')
>          task_deps['parents'][task] = []
> -        for dep in flags['deps']:
> -            dep = data.expand(dep, d)
> -            task_deps['parents'][task].append(dep)
> +        if 'deps' in flags:
> +            for dep in flags['deps']:

for dep in flags.get('deps', []):
?
> +                dep = data.expand(dep, d)
> +                task_deps['parents'][task].append(dep)
>
>      # don't assume holding a reference
>      data.setVar('_task_deps', task_deps, d)


Sent with AquaMail for Android
http://www.aqua-mail.com




