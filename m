Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
	by mail.openembedded.org (Postfix) with ESMTP id 670D260116
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 03:43:53 +0000 (UTC)
Received: by mail-pg0-f67.google.com with SMTP id x23so3015368pgx.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Dec 2016 19:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=c5IIXa5cXxEl54mcmWIzUFsVxaS1Z86LQjTGXTWqMZc=;
	b=Y+HTtbqZ9Wb/9bgGD4TROZHq+JiFckssIDEwgzpzppBOvEn8uf7mb0XnPH7sXIVAVr
	iKyRQjarXxYi9ENyiDVNEjLYJhfD0BcX9SF+ox6bf+etQEoOOC6JkwguuGRbAFqjNyxz
	Uqg1TU73vdMVkr+4VCPZzy4xvarbWXG1D+wt9aeslu9E+MGr6U0U/194LHD4udRXQfbz
	nmgGoI2MgJN/WVYAsUMe23DZFEcQi/wax/00ZWFeU0GuZ+RGN+bF5k7QrdN8ky0jI8P9
	dM8C0YUUIxAxoHRj3u0WYDMoX/EnuytH+yvFOyTHsR5gJOlChx5gG+GZ6AtlocFToRIL
	ztxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:cc:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=c5IIXa5cXxEl54mcmWIzUFsVxaS1Z86LQjTGXTWqMZc=;
	b=XZ+AyGWwdbzDhEYH1Zc2c9llHTdmK4IIKzSCvPL8QvchVyRy6f15tPsgjAKUCH+ARw
	7dPoKHzdziBp4mXJPmYvJrlW3eHkOff+nogbyqYsbmAM8TVuTNbV62qy4SB4wJosJTJ0
	kNJ+bUB9YqV2Ux2IeN7lFcQeCr2T3lB4k1B7bY2ENXFZSZ/X/L0EKJDPp5nzyd7LZu5y
	wegBePEeUxnuHyNddO5J6inzRHQLzmsdhrePkw5FildvEFYHRVDMjW2FQ+/fh3BJM9ub
	/mi08IwN0+0up55MqhXg/6AqK6Hfql2BxgPvCEEo69nv+aic1zqsmymJWluatwFYNqgw
	C5iA==
X-Gm-Message-State: AKaTC031mL2HM3/dO9jlEadNzPREtPN12RR4YqEB22wDj4OJk1YHv2iVmCF0Dr/q2EXgsg==
X-Received: by 10.99.66.198 with SMTP id p189mr173875292pga.30.1481600635592; 
	Mon, 12 Dec 2016 19:43:55 -0800 (PST)
Received: from ?IPv6:2601:202:4001:9ea0:ea2a:eaff:fe0e:629e?
	([2601:202:4001:9ea0:ea2a:eaff:fe0e:629e])
	by smtp.gmail.com with ESMTPSA id
	x2sm78384092pfx.65.2016.12.12.19.43.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 12 Dec 2016 19:43:54 -0800 (PST)
To: Robert Yang <liezhi.yang@windriver.com>,
	Armin Kuster <akuster808@gmail.com>
References: <1481113881-3280-1-git-send-email-richard.purdie@linuxfoundation.org>
	<76a6f42f-b9b0-d8f0-1cca-faefe422d8e6@windriver.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <4a09bc22-8687-fdb7-9700-426165f2c546@gmail.com>
Date: Mon, 12 Dec 2016 19:43:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <76a6f42f-b9b0-d8f0-1cca-faefe422d8e6@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker: Fix world taskgraph generation issue
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
X-List-Received-Date: Tue, 13 Dec 2016 03:43:54 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


Robert,

On 12/12/2016 05:59 PM, Robert Yang wrote:
>
> Hi Armin,
>
> Morty also needs this fix, the reproducer is:
ok. thanks for point that out. I am currently working on a new pull request.

- armin
>
> $ bitbake world -g
>
> The pn-buildlist and *.dot are null,
>
> // Robert
>
> On 12/07/2016 08:31 PM, Richard Purdie wrote:
>> The processing of the "do_" prefix to tasks is currently inconsistent
>> and has resulted in "bitbake world -g" being broken as task prefixes
>> don't get handled correctly.
>>
>> Make the "do_" task prefix handling consistent through various 
>> codepaths.
>>
>> [YOCTO #10651]
>>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> ---
>>  bitbake/lib/bb/cooker.py | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
>> index 4810fe3..1fe693c 100644
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -657,6 +657,8 @@ class BBCooker:
>>          # A task of None means use the default task
>>          if task is None:
>>              task = self.configuration.cmd
>> +        if not task.startswith("do_"):
>> +            task = "do_%s" % task
>>
>>          fulltargetlist = self.checkPackages(pkgs_to_build, task)
>>          taskdata = {}
>> @@ -715,6 +717,9 @@ class BBCooker:
>>          Create a dependency graph of pkgs_to_build including reverse 
>> dependency
>>          information.
>>          """
>> +        if not task.startswith("do_"):
>> +            task = "do_%s" % task
>> +
>>          runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
>>          rq = bb.runqueue.RunQueue(self, self.data, 
>> self.recipecaches, taskdata, runlist)
>>          rq.rqdata.prepare()
>> @@ -818,6 +823,9 @@ class BBCooker:
>>          """
>>          Create a dependency tree of pkgs_to_build, returning the data.
>>          """
>> +        if not task.startswith("do_"):
>> +            task = "do_%s" % task
>> +
>>          _, taskdata = self.prepareTreeData(pkgs_to_build, task)
>>
>>          seen_fns = []
>> @@ -1322,6 +1330,8 @@ class BBCooker:
>>          # If we are told to do the None task then query the default 
>> task
>>          if (task == None):
>>              task = self.configuration.cmd
>> +        if not task.startswith("do_"):
>> +            task = "do_%s" % task
>>
>>          fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
>>          fn = self.matchFile(fn)
>> @@ -1358,8 +1368,6 @@ class BBCooker:
>>          # Invalidate task for target if force mode active
>>          if self.configuration.force:
>>              logger.verbose("Invalidate task %s, %s", task, fn)
>> -            if not task.startswith("do_"):
>> -                task = "do_%s" % task
>>              bb.parse.siggen.invalidate_task(task, 
>> self.recipecaches[mc], fn)
>>
>>          # Setup taskdata structure
>> @@ -1371,8 +1379,6 @@ class BBCooker:
>>          bb.event.fire(bb.event.BuildStarted(buildname, [item]), 
>> self.expanded_data)
>>
>>          # Execute the runqueue
>> -        if not task.startswith("do_"):
>> -            task = "do_%s" % task
>>          runlist = [[mc, item, task, fn]]
>>
>>          rq = bb.runqueue.RunQueue(self, self.data, 
>> self.recipecaches, taskdata, runlist)
>>


