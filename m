Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by mail.openembedded.org (Postfix) with ESMTP id 1F30D7BE27;
	Mon,  7 Jan 2019 16:16:34 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id e11so350476plt.11;
	Mon, 07 Jan 2019 08:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=o9Q0KGHvpOPArQ94l1Qkjy1QYPsGz3VoyO2BTl8ueRQ=;
	b=jLekSTZxC2REbTlhoW2hCzMiYm4kduIJGQ030WIUrb+DCW0J0QTtO2q4DO90ptMJY6
	N2bCd+j+NodU8htTYv4jerYcdnOfQftkxAvnJ5UTzxgIgOHiYlX/EhbM46xxOSiAFTkc
	2Zv3nqd15zzfNVhue8c+bL9DNCHY5OK85BEfpwkjD0OG0crR9MczJCFtCghVh62rUHxt
	qCf4gcOaRVmNkxGOVHd3UO6WNb8K9a2NL1VtShaIfMiTMEVFvuiyrvU7CQZ0EowhdI18
	AFtaz8k/30bXJlvCDIInbVy1iFUCs8F7K7pSOSN9WNSy2x3lNA3yHoujUtpQiAVMrlV8
	SAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=o9Q0KGHvpOPArQ94l1Qkjy1QYPsGz3VoyO2BTl8ueRQ=;
	b=isjZ1U1mLKyn1guw7nqb8qL18/AssLMrL+kahbjg6Fk/ZXVMJZ5IFp2KgeHgeWSifZ
	EzNnJsjgmhrvjCggU/xqmXmsd4HVvM0/jcWVjU/+fOwU2oXdRFk/mYOPo0RqO/9TSNCL
	Bf5zsWeVD8pqfN7TW0dlcpb/eYxRP14F0gETUDplBaPWSYZ65sUfLtckxhNfxSacmfUJ
	D+uy+DDyjfDbcxhlOBWhniZf92yO5cUSq2f3xqxkFQJ7Uf++w8tdTI+ih9dQuJDrlZwU
	N5USxzOlD3bbY9r9KaON0DkmmmgtAxFLsZ6OvRifc6NI05cGcW6wfZo43ezV7ZZFu3Eu
	oFtw==
X-Gm-Message-State: AJcUukeHjOw444ZAgAK1ysp7Weyd+HCvK95G/ZiM54szcCHd7IOh1ELC
	caH2Vjvja84IVzXAkcyOPf6pM6Ps
X-Google-Smtp-Source: ALg8bN55aKPuquB5FfgaPiYwYaPJU5ywx+6SvK9EVcP8UpjACoFQbNPtzM2V5zPsw764N7OTearEjw==
X-Received: by 2002:a17:902:7d82:: with SMTP id
	a2mr62235622plm.163.1546877794930; 
	Mon, 07 Jan 2019 08:16:34 -0800 (PST)
Received: from ?IPv6:2601:202:4180:c33:21a4:5773:d643:ed99?
	([2601:202:4180:c33:21a4:5773:d643:ed99])
	by smtp.gmail.com with ESMTPSA id
	f13sm93823645pfa.132.2019.01.07.08.16.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Jan 2019 08:16:34 -0800 (PST)
To: Joshua Watt <jpewhacker@gmail.com>,
	Alejandro Hernandez <alejandro.enedino.hernandez-samaniego@xilinx.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
	<20181219031033.28045-4-JPEWhacker@gmail.com>
	<d41b6e89-8450-58c9-13fb-6437332f3f20@xilinx.com>
	<CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	mQINBFnlUP4BEADpKf+FQdLykenQXKk8i6xJNxDow+ypFeVAy8iFJp7Dsev+BtwUFo8VG7hx
	Jmd71vHMw+coBetWC3lk+IKjX815Ox0puYXQVRRtI+yMCgd6ib3oGxoQ8tCMwhf9c9/aKjaz
	mP97lWgGHbiEVsDpjzmMZGlJ6pDVZzxykkJExKaosE46AcA8KvfhRQg5zRyYBtinzs8Zu8AP
	aquZVHNXxPwjKPaSEEYqQjFeiNgFTavV+AhM2dmPmGUWCX9RZisrqA4slGwEB0srMdFf12Zg
	mD35Y9jZ80qpu5LPtJCFcsaAlebqR+dg36pIpiRR+olhN1wmC6LYP1vw6uMEYBjkTa2Rnb6+
	C4FDzCJD4UCrUvLMNeTW810DY0bjMMj3SfmSGSfQUssaaaTXCVlLGuGxyCr/kza1rHaXMKum
	Ek4EFj1fyn7AfkSLEHfJfY4sO1tpgigvs4eD/4ZSQEXSu/TjVvyKx4EvUbhlGMRyH2CPwD/H
	7DFF8tcVtJvCwUUW+zKtjxjSSLrhniNMXAOQJZ6CdaqCe4OyJQT5aRdr+FWbBRjpaRCCf5nf
	dTc88NMU9PrBT3vu0QJ5WNPO6MJpnb+d8iMNLZAz8tv8JMm2l+sMcNKSJ6lhX8peoBsfMVqc
	FgiykEO0fUt7DCbUYR5tLjM/3E5tHvTjMooVJyOxoufVLYtTtQARAQABtCFha3VzdGVyODA4
	IDxha3VzdGVyODA4QGdtYWlsLmNvbT6JAj0EEwEIACcFAlnlUP4CGyMFCQlmAYAFCwkIBwIG
	FQgJCgsCBBYCAwECHgECF4AACgkQ7ou0mfRW5/kuhRAAlR2FTq5572jrX5nnPR7AqI2bvSVb
	vqGLlvv739WhghvagbC+tu05QguopAhWW1/DcHK2+QtfIoC9UZrSW4RaO0CCo5sPjqK7l1KT
	ngWX/rGjF6xTF2QN0U/btcpMyVN2CNtVLwsDF9e+GHKoUcnFkP+JP8vHGokN9k6E/c97hLaL
	IJPeKl8LZXc2Efk+MaW1NXkfDJdcp/p+voajbihSQO6OZ/o+x9d2I3ZybKfTZ71+ek5Hxzjz
	g6KkMOI7KJjlmBlrQFAtVbS+CFAKrwkYznE6ggkcmGv3N7DeUBTUR78hf+EZEAM+ajeLMtrG
	rXE00pIb+gLGYPZxba5pCdQ+qWUW38qi9UnIRPm6fq7Ypx1r6XwJvbgCOkhbxo3D4YUdyC0b
	FE9lgrg8htbc9in4j2+hVI6ALswNjLprzXdzdKrd+T3Egx36o3Z/qrYsW2o5/A5sVvvASVKi
	wRPuEKhEhfmiHUPLvuKqhMoymHaz3fg5D2Q8G0gSDkLgeEpAjiWqf4+AGLx+MSDai7DSOsmI
	t61kWxs7cFTB32UrB/TDoVNn3Fm88ZFQpA/bngikE9jgEm045mSY86fNlbFj2mcCd0Ha1i1n
	aYc97RpgfjNMWyHDVHOGrNg/hJjkGa5RsAXkfyBwltHRw0Hj4urUQ3rr8um8PLe43SezPwXA
	oRoyDxC5Ag0EWeVQ/gEQALNHwj5VSPdnvXy1RXUuH+rclMx4x8zaqDyY0YqHfA7b/d8Y0VAt
	Y6YpzDeFTwD8A0Wfb7kZ2mlDIE6ODCB71uT/E3C6b+FiiN+lgzslznjUW+9l8ddDhRrC8HMG
	37vrXF5h++PTXUKEKUlkDib1w093tu3mlJXUvIAzl8CEHkptF6Br0L9XxFwuWoNUfjT9IorQ
	0SVIhvq5PhVAITXUD5fD7/N8B4TYegmHFRo1UaaKSnSHwlJJkzKpeWOH8QTYrP0RHxX86Obv
	IZuwbAo3F3oojcvLJt9NxWnbEmEALkleklLZnukgu7q5Wp1VDwhUbMFTLb6qmnBa/Xi30uOk
	0l1TMHDbeQswvQDOZBAMukSRqyBetKxQ3iTfZ/3z1ubQRcVDbVlMDScSHQq0LK3F9yMOMM/6
	0QPqJjl13xn/+Bn7WJiAIXXwzAV7uo6i0khFfjDtCDQ40aeffqOLxp1yMLkc3EKJGcQ5F6O2
	ycEf4QXCYUbMXjxB0EJB8y7z+xOi5Mmd/pPlVmZ2gQK84NAL90p7n7jRlyf3gOUY+JOl4c5e
	UFiIhOzmuqNrvPOiZ02GXh6SGUU5y7IgSoIKvXSFgHAn2OG/tcspBmkyv6IuNVpmbmEgYn4I
	Rnt40UXVQkxTh0dENFhk2cjunMYozV/OqYCgmZLFSeJd8kAo4yn+yOtNABEBAAGJAiUEGAEI
	AA8FAlnlUP4CGwwFCQlmAYAACgkQ7ou0mfRW5/nNcg//R63cbOS6zLtvdnPub3Ssp1Ft8Wmv
	mni+kccuNApuDV7d63QckYxjAfUv2zYMLpbh87gVbLyCq9ASn552EbfRhTvHdk44CgbHBVcI
	ZBEdZWgRR5ViJakQSYHpP2e5AGNFnx9gSIuRTaa5rvZM+4xeoZ2vJiq93TtaYPr7UFNfK+c4
	vv4C66lkt9l95/I10eSc3RqbOKZW47emlg4X3ygEoB9k2lPrpspyf6sUuSEi0WrlSxoLAr6p
	JG8rTUErYNeXe6JCdL31odDx1Dh5sdKIj2RicUYZNilxu9f1M7jZwf2ra1FGAlKj2ybqmgpZ
	EFteaiCinEYsvDyZyOiWHjAFI+RZIPQQL3AnVp4l7wYD3r9hnqYPww0slyMDcb9262RoFkHq
	dDwxPYarrNjWUpOzxB6bFxOgNRdCTgvQl8Ftk8a/yXB6vHeUSm1vPFCBxQPZytyfOLhEWm0J
	/mkVL0Z6iRK3p1LKnpLYCS4/esL2u7RrhPyCs2SsL58YcQF/g+PpeT9geZ+oyZ/4IQ+TWJoU
	PNHndk8VBTpzrmOaJxrebNL/W6C8JCmbLM11TAUMmHYi9JDytN8Au78hWpDbIdKwg1LeSxpw
	ZZD/OqOc0DBvHOpQhzkSrtR1lVlDV/+9E8J1T4uDhrGmZwYV+4xQetypHax8aAHisYbjXdVa
	8CS2NxU=
Message-ID: <f13165a4-016d-f2f7-7640-6716bfc9b2a8@gmail.com>
Date: Mon, 7 Jan 2019 08:16:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJdd5Gbik0fCVCoWYzwYF7ND6G35ADeX0UdAk1_2X7k2TcnPQw@mail.gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	OE-core <openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH v5 3/8] bitbake: runqueue: Track task unique hash
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
X-List-Received-Date: Mon, 07 Jan 2019 16:16:34 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 1/5/19 7:09 PM, Joshua Watt wrote:
> On Sat, Jan 5, 2019 at 1:50 AM Alejandro Hernandez
> <alejandro.enedino.hernandez-samaniego@xilinx.com> wrote:
>> Hey Joshua,
>>
>> This is breaking multiconfig builds with the following error (trimmed),
>> I believe it is not taking into account that the Key could contain
>> "mc:..." if it is a multiconfig build.
> Hmm, yes that seems likely. I'll take a look, would you mind opening a
> bug in Bugzilla and assigning it to me? I'm not very familiar with
> multiconfig, so some instructions to help reproduce would be very
> helpful.
>
> Does anyone know if mutliconfig is tested on the autobuilders?
We don't as far as I know.

Do we need to bug this as this patch in in master.

- armin
>
>>
>> ERROR: Running idle function
>>   File "poky/bitbake/lib/bb/runqueue.py", line 1170, in
>> RunQueueData.prepare_task_hash(tid='multiconfig:x86:poky/meta/recipes-support/attr/acl_2.2.52.bb:do_fetch'):
>>               self.runtaskentries[tid].hash =
>> bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>      >        self.runtaskentries[tid].unihash =
>> bb.parse.siggen.get_unihash(fn + "." + taskname)
>>
>>    File "poky/bitbake/lib/bb/siggen.py", line 45, in
>> SignatureGeneratorOEBasicHash.get_unihash(task='poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'):
>>           def get_unihash(self, task):
>>      >        return self.taskhash[task]
>>
>> KeyError: 'poky/meta/recipes-support/attr/acl_2.2.52.bb.do_fetch'
>>
>>
>> Cheers,
>>
>> Alejandro
>>
>>
>> On 12/18/2018 7:10 PM, Joshua Watt wrote:
>>> Requests the task unique hash from siggen and tracks it
>>>
>>> [YOCTO #13030]
>>>
>>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>>> ---
>>>   bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
>>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>>> index f2b95a9829b..27b188256dd 100644
>>> --- a/bitbake/lib/bb/runqueue.py
>>> +++ b/bitbake/lib/bb/runqueue.py
>>> @@ -346,6 +346,7 @@ class RunTaskEntry(object):
>>>           self.depends = set()
>>>           self.revdeps = set()
>>>           self.hash = None
>>> +        self.unihash = None
>>>           self.task = None
>>>           self.weight = 1
>>>
>>> @@ -385,6 +386,9 @@ class RunQueueData:
>>>       def get_task_hash(self, tid):
>>>           return self.runtaskentries[tid].hash
>>>
>>> +    def get_task_unihash(self, tid):
>>> +        return self.runtaskentries[tid].unihash
>>> +
>>>       def get_user_idstring(self, tid, task_name_suffix = ""):
>>>           return tid + task_name_suffix
>>>
>>> @@ -1150,18 +1154,21 @@ class RunQueueData:
>>>                   if len(self.runtaskentries[tid].depends - dealtwith) == 0:
>>>                       dealtwith.add(tid)
>>>                       todeal.remove(tid)
>>> -                    procdep = []
>>> -                    for dep in self.runtaskentries[tid].depends:
>>> -                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
>>> -                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>>> -                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>> -                    task = self.runtaskentries[tid].task
>>> +                    self.prepare_task_hash(tid)
>>>
>>>           bb.parse.siggen.writeout_file_checksum_cache()
>>>
>>>           #self.dump_data()
>>>           return len(self.runtaskentries)
>>>
>>> +    def prepare_task_hash(self, tid):
>>> +        procdep = []
>>> +        for dep in self.runtaskentries[tid].depends:
>>> +            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
>>> +        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
>>> +        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
>>> +        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
>>> +
>>>       def dump_data(self):
>>>           """
>>>           Dump some debug information on the internal data structures
>>> @@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
>>>                   deps = self.rqdata.runtaskentries[revdep].depends
>>>                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>>>                   taskhash = self.rqdata.runtaskentries[revdep].hash
>>> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
>>> +                unihash = self.rqdata.runtaskentries[revdep].unihash
>>> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>>>                   for revdep2 in deps:
>>>                       if revdep2 not in taskdepdata:
>>>                           additional.append(revdep2)
>>> @@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
>>>                   deps = getsetscenedeps(revdep)
>>>                   provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
>>>                   taskhash = self.rqdata.runtaskentries[revdep].hash
>>> -                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
>>> +                unihash = self.rqdata.runtaskentries[revdep].unihash
>>> +                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
>>>                   for revdep2 in deps:
>>>                       if revdep2 not in taskdepdata:
>>>                           additional.append(revdep2)


