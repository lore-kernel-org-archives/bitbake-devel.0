Return-Path: <matt@madison.systems>
Received: from mail-lf0-f51.google.com (mail-lf0-f51.google.com
	[209.85.215.51])
	by mail.openembedded.org (Postfix) with ESMTP id DE16973169
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 21 Aug 2016 13:09:59 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id g62so60768386lfe.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 21 Aug 2016 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Om6KvATVR0sEWTjh9GJ2TBTdSC//++G1RTTzTSeDBLo=;
	b=eUvLmQbO6RKGw5GJeXtgAoNb6stIxmLJ73J3tbHGiZgq79PwFjAcnu6giMNKpy2+kN
	vbnWhnxvFdeRY618j92yZLa7FyWhSGorWKVhw5jaJ7ESwoSVDkwRovM3ZAhgZrKsp0Ms
	37AFRf3DB36krHLCYM5ic+t0Jpu838wb7BT73dqAJxj7tMjozU+/jJu434Ij9yTOMCZE
	4FSpOYj+hV1EdB+Y50OZBIRurRSqGoUlqJmm7ZOt4gxXZG5LJWhQSbh7yHdErMM+eFsa
	BZ6Le0QLlJlyfBrTJEdGizK2rb6TYw96U46xxiMCEjnuHCBGV4/rNqMpqfDZ/j/Pmfae
	xH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Om6KvATVR0sEWTjh9GJ2TBTdSC//++G1RTTzTSeDBLo=;
	b=OVgMcjz113gohw6eG29BQkPa2/e2wQ1BRgOttRJxQOKrWxyJl5bqRFzzsqVgOIfqTg
	1Yi349Q0A3VfWKcqTVUE4pJ3uoxKjhdUkGVqMwsL+2yG1yDAB53IVG9wlR8T6m2dL+RY
	CRMfOvLU8O0bEK3LNHYtfLE7lb1HAokQBU0OX9dmLXAydOSSJUIgShaqmxoORpi+FL2U
	kN23oQPYcQDAhEqSeTP1IdfyLnb787Mvo3Z+94KO7qKJzvAdmlCnuAmOxhjEggbmT1mx
	QmMe927g1jG46jlYhfQdd1/SjCXxrg6x0V0zEiCEFwyuSMjY91YWd8s9LTfbJgbFEooW
	sxNg==
X-Gm-Message-State: AEkoousNi/7qty1bUczlMPa5RqU77vET7c6A0Bxfj8WD+/AhL7SdlFHZh3wCMJxq++PMVB41yWmS0Brf+cOoMg==
X-Received: by 10.46.1.224 with SMTP id f93mr4088044lji.44.1471784999497; Sun,
	21 Aug 2016 06:09:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.24.162 with HTTP; Sun, 21 Aug 2016 06:09:59 -0700 (PDT)
In-Reply-To: <1471705829.16712.70.camel@linuxfoundation.org>
References: <1470848896-23041-1-git-send-email-matt@madison.systems>
	<1470848896-23041-2-git-send-email-matt@madison.systems>
	<1471705829.16712.70.camel@linuxfoundation.org>
From: Matt Madison <matt@madison.systems>
Date: Sun, 21 Aug 2016 06:09:59 -0700
Message-ID: <CAGgRHJq+vX+NSL7uphpPo9dhoVcC7jMFyZvoaJQ4KB-a_NAoRA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2] fetch2: preserve current working directory
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
X-List-Received-Date: Sun, 21 Aug 2016 13:10:00 -0000
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 20, 2016 at 8:10 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Wed, 2016-08-10 at 10:08 -0700, Matt Madison wrote:
>> Fix the methods in all fetchers so they don't change
>> the current working directory of the calling process, which
>> could lead to "changed cwd" warnings from bitbake.
>>
>> Signed-off-by: Matt Madison <matt@madison.systems>
>> ---
>>  lib/bb/fetch2/__init__.py  | 21 +++++++++++----------
>>  lib/bb/fetch2/bzr.py       | 11 ++++-------
>>  lib/bb/fetch2/clearcase.py |  6 ++----
>>  lib/bb/fetch2/cvs.py       | 15 ++++++++-------
>>  lib/bb/fetch2/git.py       | 45 ++++++++++++++++++++----------------
>> ---------
>>  lib/bb/fetch2/gitannex.py  | 24 +++++++++++-------------
>>  lib/bb/fetch2/gitsm.py     | 23 ++++++++++-------------
>>  lib/bb/fetch2/hg.py        | 28 ++++++++++------------------
>>  lib/bb/fetch2/npm.py       | 22 +++++++---------------
>>  lib/bb/fetch2/osc.py       | 10 ++++------
>>  lib/bb/fetch2/perforce.py  |  6 ++----
>>  lib/bb/fetch2/repo.py      | 13 ++++++-------
>>  lib/bb/fetch2/svn.py       | 13 +++++--------
>>  13 files changed, 100 insertions(+), 137 deletions(-)
>
> Thanks for this, sorry it took a while to merge. It does looks like a
> pretty good cleanup of this code and is much appreciated!

No problem, I figured it would take some time.

> I did wonder if we still needed the try_mirror chdir now we've cleaned
> up the individual fetchers?

I'll check into it and send out a follow-up patch to remove the
remaining chdir's and getcwd's.

Thanks,
-Matt

>
> Cheers,
>
> Richard

