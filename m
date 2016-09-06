Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 380376010B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Sep 2016 13:26:34 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id w12so92043235wmf.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Sep 2016 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=T+eAtzrE4nKmTT8zgQYXCH106CXsVArz0ppx2O6g3c0=;
	b=Gk5EgqwK+ErQcWkD2z+O49kjXXZ4+pWfIWLrkEkZHtLyAW9/j1QpyWLCDdAfP3rrK4
	08k4+TmMlrZ0DbF92NZddHhrPCX1rb4fJZ4scMD8hTdjMA3ayQWWJmmTsyYWbu6S9ZJA
	IEsU3yqfxs2/KtlT1HdHwaRECYbmTPOan96mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=T+eAtzrE4nKmTT8zgQYXCH106CXsVArz0ppx2O6g3c0=;
	b=cwc4t9QB2FsjuwB9ASGzVrYkhiOdtL8RJgiAbSuV+uo9pBSBmdykc6PhvbrMtytcLj
	Nqzvh55Q8UMGSNtk2BEmOiDJoaovnyoea7eEefYLDYYKewtKGqxoyldjf4L7OoOEo77l
	kef84bXLKRslctv5a7nzEHz2P890nQ99KSVIFRWaPUuTZoDvpbNu5DI6bs4v25TwYqqO
	X+lNX/GgCXGN/eXB10bhsCBZmIh2x2hmrsiy1TVpKItwIQDxPqYTWyNfPFFyJYNJ8DZj
	jN2TA9rFx4akPIWlxRVCkhXNVkrHhQdgGJ7v2C6Y+ews+9m2wyzXeZUoqIpyJa4haUQ7
	CrYg==
X-Gm-Message-State: AE9vXwPrfi4QhTBhYPBxJopUVf8ayxr4/SnUtKarSMMDbpPCo6ZLHDGS+NwONudhMY7aJ+vEuvelMBgUOLPS6sXb
X-Received: by 10.194.103.3 with SMTP id fs3mr36573394wjb.115.1473168395245;
	Tue, 06 Sep 2016 06:26:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.120.162 with HTTP; Tue, 6 Sep 2016 06:26:14 -0700 (PDT)
In-Reply-To: <1473167957.20226.44.camel@linuxfoundation.org>
References: <1473162780-11643-1-git-send-email-nicolas.dechesne@linaro.org>
	<1473167957.20226.44.camel@linuxfoundation.org>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Tue, 6 Sep 2016 15:26:14 +0200
Message-ID: <CAP71Wjy6rY84XQPCR-Tg2ixJby+=tvZFf4BB7vexTpQJo+j8nA@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb/build: create .old symlink for run.do_xx and log.do_xx
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
X-List-Received-Date: Tue, 06 Sep 2016 13:26:36 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 6, 2016 at 3:19 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2016-09-06 at 12:53 +0100, Nicolas Dechesne wrote:
>> When they exist, keep a reference to the 'previous' (or old) build
>> for run.do_xx
>> and log.do_xx files, which can be useful when debugging. The symlink
>> are created
>> as run.do_xx.old and log.do_xx.old.
>>
>> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
>> ---
>>  lib/bb/build.py | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>
> We keep the old logfiles around and "ls -t" is comparatively straight
> forward. Do we really need this extra complexity?

i can't really say that I *need* them, it is definitely not something
vital, just a convenience. It is often that I compare current and old,
so having convenience symlink for both seemed to be a good idea.

