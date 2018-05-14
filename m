Return-Path: <akuster@mvista.com>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
	[209.85.160.67])
	by mail.openembedded.org (Postfix) with ESMTP id 7792575527
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 14:49:26 +0000 (UTC)
Received: by mail-pl0-f67.google.com with SMTP id c19-v6so7516467pls.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=/arfJsl0HKytD4Erqe4560QD7BEvET2Z8XyAc44PARA=;
	b=JlAkv+JNMjucLtbg+6CblU03ffz0cvBK+26SUVb6ldVS6dI/3C/hUVy+d9lLWEGXoQ
	A+Qdsl4xbG/BXxRIIBAzXN7jElNt/LWEpLkp8q6JfP7NvnM3jxMNj8WIGHzQnv0fJMcO
	oM9++PNil1POZ4UC0+2GyhG1g3EJANxUthKj2mAUiuXiMlO+bnRXqWava4T0rkibuSJ6
	tRA1/Q0dBwTzkb74DkbDPmNNveNbSEJw+RlyjrACFeffBifuyyf3DHuEGjsvGfGmcOj7
	saFOY5qyL2WXg/JoKOEH13k1um/cTOWYaPtxb5ZC0RHyzCqYw0QkRN3l/cLbadUav3wj
	SBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=/arfJsl0HKytD4Erqe4560QD7BEvET2Z8XyAc44PARA=;
	b=uSIznAnnQmZ98BTo43XiobGrLui7HA/Cv6ln9J/K9OEA/xgMXibqteQ4iz/iAupFDL
	d350toEaeDtrCOR8KiKFYXBIt+DsC/Kb4azFj0zPX9uX3A6h059byEvdlqQ/97EoN5si
	qKHuYftMDr5lquBeIg4GdjTLyMDNYc8k4feT+SMzWo8dUhkDRenzWg/fRy5cORampbx4
	jTopUYLXCcQY79IPzJzPSZK0QyhMcO2vt1x10u4DD25u+AAV0X97v6lW3v2r0iJgE4kW
	NF4iL8tNPc+rbo/ovkgLKuWq6V5flM336KmUjChQlD8cF3h9DVaVZBUKtUevMBwFIBNp
	3fdQ==
X-Gm-Message-State: ALKqPwfxmyTqOHMOHwzG+6eNAfQuIzWTyMqptbZMvLf91qeQZBSkTOld
	s9eGgpOuqoE75sFxbKvWcv6CjoRf/fM=
X-Google-Smtp-Source: AB8JxZrK4koRiGdbKrsMMOVx4JLL0pPOctSzFZTAEWfkV4/gqICnMVn80vNZX3lt3sdb0XVJMWOkEA==
X-Received: by 2002:a17:902:5a0d:: with SMTP id
	q13-v6mr10249467pli.199.1526309367827; 
	Mon, 14 May 2018 07:49:27 -0700 (PDT)
Received: from ?IPv6:2601:202:4000:1184:a998:689b:691:198f?
	([2601:202:4000:1184:a998:689b:691:198f])
	by smtp.gmail.com with ESMTPSA id
	p71-v6sm25407334pfl.170.2018.05.14.07.49.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 14 May 2018 07:49:26 -0700 (PDT)
To: Mark Hatle <mark.hatle@windriver.com>, bitbake-devel@lists.openembedded.org
References: <20180514142139.165484-1-mark.hatle@windriver.com>
	<20180514142139.165484-3-mark.hatle@windriver.com>
From: akuster <akuster@mvista.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster@mvista.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <c6903b28-23b8-5e1d-174f-7f007b3eae7c@mvista.com>
Date: Mon, 14 May 2018 07:49:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514142139.165484-3-mark.hatle@windriver.com>
Subject: Re: [PATCH 2/2] runqueue.py: Initial implementation of per task process limits
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
X-List-Received-Date: Mon, 14 May 2018 14:49:27 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US



On 05/14/2018 07:21 AM, Mark Hatle wrote:
> On high core machines, in do_fetch, it is possible to DDoS your own machine.
If this is the case, isn't a CVE warranted?  Also, which version does
this issue affect?

Thanks for fixing this.
Armin
> A method to limit any arbitrary task type to a certain number of simultaneous
> threads is needed.  (Similar to how BB_NUMBER_THREADS works in the general
> case.)  The format of this new limitation is:
>
>     do_fetch[number_threads] = "2"
>
> This should be set globally.  If it is set in individual recipes it could
> result in unpredictable behavior.
>
> Note: a value for number_threads > BB_NUMBER_THREADS will have no effect.
>
> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> ---
>  lib/bb/runqueue.py | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index a937a0b..2d9e18d 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -134,6 +134,7 @@ class RunQueueScheduler(object):
>          self.prio_map = [self.rqdata.runtaskentries.keys()]
>  
>          self.buildable = []
> +        self.skip_maxthread = {}
>          self.stamps = {}
>          for tid in self.rqdata.runtaskentries:
>              (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
> @@ -150,8 +151,25 @@ class RunQueueScheduler(object):
>          self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
>          if not self.buildable:
>              return None
> +
> +        # Filter out tasks that have a max number of threads that have been exceeded
> +        skip_buildable = {}
> +        for running in self.rq.runq_running.difference(self.rq.runq_complete):
> +            rtaskname = taskname_from_tid(running)
> +            if rtaskname not in self.skip_maxthread:
> +                self.skip_maxthread[rtaskname] = self.rq.cfgData.getVarFlag(rtaskname, "number_threads")
> +            if not self.skip_maxthread[rtaskname]:
> +                continue
> +            if rtaskname in skip_buildable:
> +                skip_buildable[rtaskname] += 1
> +            else:
> +                skip_buildable[rtaskname] = 1
> +
>          if len(self.buildable) == 1:
>              tid = self.buildable[0]
> +            taskname = taskname_from_tid(tid)
> +            if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
> +                return None
>              stamp = self.stamps[tid]
>              if stamp not in self.rq.build_stamps.values():
>                  return tid
> @@ -164,6 +182,9 @@ class RunQueueScheduler(object):
>          best = None
>          bestprio = None
>          for tid in self.buildable:
> +            taskname = taskname_from_tid(tid)
> +            if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
> +                continue
>              prio = self.rev_prio_map[tid]
>              if bestprio is None or bestprio > prio:
>                  stamp = self.stamps[tid]


