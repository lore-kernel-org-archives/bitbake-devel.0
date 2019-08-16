Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id A11067F327
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 16:20:21 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id p17so2062906wrf.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=WpDAQUxwNWQVTVHgnMIzxuBNFbew9qC/gXIwN468kv0=;
	b=FfFB4eycaP0j1MdPRuFpY1FKYtZFy5lWvbjZJfpcvC18AD6YgzUbKQD2doizX+rbIK
	4p6y1vNPuialXIrOxv4JBnSB7t43akkccK6bfLrVN+kB4epmFiCTZ7rQgSY+KRZS+PyW
	S1tiqz4pIznS3m7NYgzrvShIR/kpKA1GtzVo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=WpDAQUxwNWQVTVHgnMIzxuBNFbew9qC/gXIwN468kv0=;
	b=KCcXfgNMFsV/eYeou5SoNfSzQW/Y/aq45+mg2YpyzKHpjXo7sTClAVptDlpVnaM1Se
	gpJ4F0ulxqajp0XtH2A+wCvBor87SUmkyDSban8X//OGsz/2S0yHxIXKiUDrAwD8yBKc
	hr+/jOB6X5bmBImb7gO3lkFvJVvAPSW+CXakKt1EcnvSzwM8e9xHyllTxww0wQl4bAf/
	AujPs6UMi9dLEUgJ4xVl3/YUbUkWSOLQPPILpgVJKmX/gal5Dk9U84dOA+h6yzUGhMZT
	TaeoIty3mTW1867lkYf8g66pnVeNdBQmhtCOLzRw6nQT2DvP2buTxCD20JJKpbpArZbr
	o7LQ==
X-Gm-Message-State: APjAAAVvXa/hCZ8hsbz6DEt/t7cj27BjUCC/8UU7tXSxxsE8Qo9eoO4h
	hWdMzc/crWXKaf0yEj7DonIOYw==
X-Google-Smtp-Source: APXvYqzIngpdAeWhyvO3i0U78jetNwEIDOyVw24C3FYHnWrMFcR3L7F3vsXzma30ys02TeYnerisYg==
X-Received: by 2002:adf:e710:: with SMTP id c16mr12486822wrm.292.1565972422243;
	Fri, 16 Aug 2019 09:20:22 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r15sm9260988wrj.68.2019.08.16.09.20.21
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 09:20:21 -0700 (PDT)
Message-ID: <4e31ef6da04f535033fa70a52589bba5f4406c1e.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 17:20:20 +0100
In-Reply-To: <20190816105824.32765-1-pkj@axis.com>
References: <20190816105824.32765-1-pkj@axis.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCHv2] runqueue: Add a progress meter for checking the task stamps
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
X-List-Received-Date: Fri, 16 Aug 2019 16:20:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-08-16 at 12:58 +0200, Peter Kjellerstedt wrote:
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/runqueue.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 7fa074f679..86dbd16def 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -2672,9 +2672,16 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
>          stamppresent = []
>          tocheck = set()
>  
> +        msg = "Checking task stamps"
> +        bb.event.fire(bb.event.ProcessStarted(msg, len(sqdata.sq_revdeps)), cooker.data)
> +
> +        checked = 0
>          for tid in sorted(sqdata.sq_revdeps):
>              (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>  
> +            checked = checked + 1
> +            bb.event.fire(bb.event.ProcessProgress(msg, checked), cooker.data)
> +
>              taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
>  
>              if 'noexec' in taskdep and taskname in taskdep['noexec']:
> @@ -2696,6 +2703,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
>                  continue
>  
>              tocheck.add(tid)
> +        bb.event.fire(bb.event.ProcessFinished(msg), cooker.data)
>  
>          valid = rq.validate_hashes(tocheck, cooker.data, len(stamppresent), False)

This was discussed on irc. The performance patches which I've posted
should remove the need for a progress bar on this section of code. We
really shouldn't be taking a long time here...

Cheers,

Richard


