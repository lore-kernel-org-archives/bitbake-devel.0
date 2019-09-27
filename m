Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail.openembedded.org (Postfix) with ESMTP id D28847F347
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 13:35:45 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id q1so16444252ion.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:references:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=qQPOnIbvgAMZeiBIwXLxYFmlF0Ko3v/UEfNR3Ut4kzI=;
	b=V2q+KOMvmxUfCP6233t008ngh6JCOJ2zHwyB8Q4mN2iO1FmV3/f0GvxVFinR9usqbs
	zn7UVbRpOXJCf1HI0kWnkW73XLHI8/t2fSZYPEZylno1sdlbLYUjT/7O0Ed4JvqZIy0p
	ZPjy+HqwrZyqQKcOlmd069ICi5R99AonwcZJnEuGWYPhaTZyozh9EL1jdu+TNz6W4m7w
	KY5tfMMUhyH88FQ6/iBRiv3EE63TvONIKTLKd65rvqZbDHTb1X5kIhTSs9abJ59Q76l/
	9K2H6Ouk0RZP5IgV0eghneCmKB84uwUTHBDXVI+o5V6/iKRixrqrUzFb1Ao25CKPUGmy
	x4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=qQPOnIbvgAMZeiBIwXLxYFmlF0Ko3v/UEfNR3Ut4kzI=;
	b=bt77jH4/1Pz5QtQrgpIasQMd5ppfum22oTysVSpdkBWamGoHFQZ57Sk9zD5VqiAtpY
	9Sxfbng9MR4hSt2a1TJaerBP9hqbeqRlCEWnCX0P5cR/AwbR3peSDzADMZeHIVZL3YKL
	8HR+/n3iGGq8jPWo6iAfVtwmHsVKSfbGQltRPPpuGaL07nZnfaDjl5KB2wtUxBwiHDe9
	AQybSNMB3M607cYe4nn1t3gAJt+JEcXxYBqwbkqAHbGCCNiJQzqKIUf2OB3ef0N5Htms
	5hiyErd+47Colq+NPeuj9a+Mdv1NpCpQZ7zTBj1QF+psgaFmko4wSVrMrQ8oxjW+TgFz
	gkxQ==
X-Gm-Message-State: APjAAAXUYOgTFI/HyfDfIZQr0muHC9IrBFyZ3+l6Mg92RpP7W9N7HWGY
	hWYU/zgYJzZeJ2DemNhM9laa5CQg
X-Google-Smtp-Source: APXvYqxZlfY2ddZKtz6C8mpmYix2s8v8B0X04ame1821oofzYd1H8g9n26Y3/ivO0sjFviibVnbA+g==
X-Received: by 2002:a02:9f02:: with SMTP id z2mr7834404jal.78.1569591345782;
	Fri, 27 Sep 2019 06:35:45 -0700 (PDT)
Received: from [10.30.197.57] ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	e15sm2150974ioe.33.2019.09.27.06.35.44
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
	Fri, 27 Sep 2019 06:35:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
	<20190927123347.19276-5-richard.purdie@linuxfoundation.org>
Message-ID: <22cd7d8c-27d9-d56e-4630-34ce3d8347fb@gmail.com>
Date: Fri, 27 Sep 2019 08:35:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927123347.19276-5-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH 5/9] siggen/runqueue: Fix signature mismatch issues
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
X-List-Received-Date: Fri, 27 Sep 2019 13:35:47 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 9/27/19 7:33 AM, Richard Purdie wrote:
> We need to set the setscene tasklist before we call into the
> taskhash/unihash code else the behaviour is inconsistent.
>
> Avoid reporting hashes for non setscene tasks since we'd never
> query that.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/runqueue.py | 3 ++-
>   lib/bb/siggen.py   | 6 +++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 65169931f1..29bfd65e0b 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -1162,6 +1162,8 @@ class RunQueueData:
>   
>           self.init_progress_reporter.next_stage()
>   
> +        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
> +
>           # Iterate over the task list and call into the siggen code
>           dealtwith = set()
>           todeal = set(self.runtaskentries)
> @@ -1173,7 +1175,6 @@ class RunQueueData:
>                       self.prepare_task_hash(tid)
>   
>           bb.parse.siggen.writeout_file_checksum_cache()
> -        bb.parse.siggen.set_setscene_tasks(self.runq_setscene_tids)
>   
>           #self.dump_data()
>           return len(self.runtaskentries)
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 71fa018227..6207cbca30 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -455,7 +455,11 @@ class SignatureGeneratorUniHashMixIn(object):
>           report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
>           tempdir = d.getVar('T')
>           fn = d.getVar('BB_FILENAME')
> -        key = fn + ':do_' + task + ':' + taskhash
> +        tid = fn + ':do_' + task
> +        key = tid + ':' + taskhash
> +
> +        if self.setscenetasks and tid not in self.setscenetasks:
> +            return

Would this be worth of a bb.fatal() (or perhaps a bb.warn()) to try and 
discover issues sooner?


>   
>           # Sanity checks
>           cache_unihash = self.unitaskhashes.get(key, None)

