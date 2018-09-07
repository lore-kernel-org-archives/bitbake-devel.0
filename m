Return-Path: <jan.kiszka@siemens.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id 5790B797A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 09:48:17 +0000 (UTC)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w879mG39004466
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Fri, 7 Sep 2018 11:48:16 +0200
Received: from [167.87.129.4] ([167.87.129.4])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w879mDXb021712;
	Fri, 7 Sep 2018 11:48:15 +0200
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
References: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
	<2ba43936a9d6d2a1baac49c419cdc5c86cbbdbf1.camel@linuxfoundation.org>
	<f22cc8eccc5b47a29c87de3b6ad9193d22f486b6.camel@linuxfoundation.org>
	<66fb849c-41d7-650a-046c-bc09e76fd594@siemens.com>
	<6b0aad97f792be57f477f2d38ab8f10c9ee16dbc.camel@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6e52b650-48c1-63a6-f7e2-3d25fc026c2b@siemens.com>
Date: Fri, 7 Sep 2018 11:48:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <6b0aad97f792be57f477f2d38ab8f10c9ee16dbc.camel@linuxfoundation.org>
Subject: Re: [PATCH] process: Flush server stdout/stderr before reporting failure
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
X-List-Received-Date: Fri, 07 Sep 2018 09:48:17 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-09-05 02:14, richard.purdie@linuxfoundation.org wrote:
> On Tue, 2018-09-04 at 15:09 +0200, Jan Kiszka wrote:
>> Looks similar on first glance, but it only partly helps with
>> exceptions.
>> We get from
>>
>> $ bitbake | cat
>> ERROR: Unable to start bitbake server
>>
>> to
>>
>> $ bitbake | cat
>> ERROR: Unable to start bitbake server
>> ERROR: Server log for this session (/work/build/bitbake-
>> cookerdaemon.log):
>> --- Starting bitbake server pid 149 at 2018-09-04 13:02:15.144583 ---
>>
>> while it should have
>>
>> $ bitbake
>> ERROR: Unable to start bitbake server
>> ERROR: Last 10 lines of server log for this session
>> (/work/build/bitbake-cookerdaemon.log):
>> Traceback (most recent call last):
>>     File "/work/isar/bitbake/lib/bb/daemonize.py", line 77, in
>> createDaemon
>>       function()
>>     File "/work/isar/bitbake/lib/bb/server/process.py", line 433, in
>> _startServer
>>       self.cooker = bb.cooker.BBCooker(self.configuration,
>> self.featureset)
>>     File "/work/isar/bitbake/lib/bb/cooker.py", line 178, in __init__
>>       self.configwatcher = pyinotify.WatchManager()
>>     File "/work/isar/bitbake/lib/pyinotify.py", line 1764, in __init__
>>       raise OSError(err % self._inotify_wrapper.str_errno())
>> OSError: Cannot initialize new instance of inotify, Errno=Too many
>> open
>> files (EMFILE)
> 
> The more I looked into this the more problems I found. I've put this in
> for some testing which should address the issues:
> 
> http://git.yoctoproject.org/cgit.cgi/poky/commit/?h=master-next&id=dae574dd680f4f9db0b1447266742fa127963842
> 

Yep, it does here as well!

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

