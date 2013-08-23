Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
	[209.85.214.176])
	by mail.openembedded.org (Postfix) with ESMTP id EB28B60896
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 14:52:53 +0000 (UTC)
Received: by mail-ob0-f176.google.com with SMTP id uz19so754541obc.21
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 07:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=P46Yc6pltDjJrTmshGkplPXWP2/I/gEz1pNQCcM2MzI=;
	b=n5fRj5yfa61y35JdjphsV7y6fOXcCFrc1ReohzCbw+f3PEfTz+k0E0rvO4fHyz2jEG
	agAPOvLB7SzwnTfpRQ4tgtadUfEl5kHrIOywVCFo91EbEI7pJRjpgT03za2cFO99ZDlH
	LcqxHLLcTxhIQGAcMNRiob8hA69PQBR2bLJf5lStSDeMBt2j6mAjhfF3CEU8O5LlFOkf
	OGtCddQdd5AvIoUznWzJbQQUJzUQQgwyhFUrmDKuEG2p9MdWPo6la1Y5ON/tRqdo/Dpt
	80VtuRnnHfUjB3Y/TJ58myCTtw3WrZoZSyLYzKpc0DAQ6XksXfjMqPv5tE4MTZx/tDRh
	OgzA==
X-Gm-Message-State: ALoCoQn3bgZuTuoStUm0V4LE/lHIniQCF2wkufkug/MnX64UgLyShOu2MT/dOoWAYcgv+xLTIhav
X-Received: by 10.182.129.233 with SMTP id nz9mr156014obb.8.1377269574504;
	Fri, 23 Aug 2013 07:52:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.172.4 with HTTP; Fri, 23 Aug 2013 07:52:34 -0700 (PDT)
In-Reply-To: <CAMKF1srp8QVHCtM7p7-dzrVPS5ipMqnDgTPt=spAsN9RVBAFkA@mail.gmail.com>
References: <1376644859-11034-1-git-send-email-nicolas.dechesne@linaro.org>
	<CAMvUbCxhEEyp5dCZjN0fidBJxxgX55CXL88ErL5u5bkz1rOdEQ@mail.gmail.com>
	<CAMKF1srp8QVHCtM7p7-dzrVPS5ipMqnDgTPt=spAsN9RVBAFkA@mail.gmail.com>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Fri, 23 Aug 2013 16:52:34 +0200
Message-ID: <CAP71WjzJwTq-1NSXSEUNbOF3KqNVsbsLhJN-_FmJcjmC+J_HYA@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patch Tracking <patches@linaro.org>
Subject: Re: [RFC PATCH] build.py: create symlink for run.do_xxx scripts
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
X-List-Received-Date: Fri, 23 Aug 2013 14:52:54 -0000
Content-Type: multipart/alternative; boundary=089e0149d28abfa84c04e49e8ff9

--089e0149d28abfa84c04e49e8ff9
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Aug 23, 2013 at 8:51 AM, Khem Raj <raj.khem@gmail.com> wrote:

> yeah its useful. Many times you just want to execute the latest run.doXXX
> and it will help there.
>

since we are quite close to the freeze for 1.5, any chance this patch can
make it into 1.5?
thx!

--089e0149d28abfa84c04e49e8ff9
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr"><div class="gmail_extra"><br><div class="gmail_quote">On Fri, Aug 23, 2013 at 8:51 AM, Khem Raj <span dir="ltr">&lt;<a href="mailto:raj.khem@gmail.com" target="_blank">raj.khem@gmail.com</a>&gt;</span> wrote:<br>

<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=":or" style="overflow:hidden">yeah its useful. Many times you just want to execute the latest run.doXXX<br>
and it will help there.<br></div></blockquote></div><br>since we are quite close to the freeze for 1.5, any chance this patch can make it into 1.5?</div><div class="gmail_extra">thx!</div></div>

--089e0149d28abfa84c04e49e8ff9--
