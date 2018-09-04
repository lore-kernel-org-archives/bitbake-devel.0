Return-Path: <jan.kiszka@siemens.com>
X-Greylist: delayed 889 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 04 Sep 2018 13:23:57 UTC
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by mail.openembedded.org (Postfix) with ESMTP id 33A3979006
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Sep 2018 13:23:57 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w84D97ql026051
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK); 
	Tue, 4 Sep 2018 15:09:08 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may
	be forged))
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w84D97IO018694;
	Tue, 4 Sep 2018 15:09:07 +0200
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <192b8cc1-4ea9-1cd7-5a3f-f4c150868a0e@siemens.com>
	<2ba43936a9d6d2a1baac49c419cdc5c86cbbdbf1.camel@linuxfoundation.org>
	<f22cc8eccc5b47a29c87de3b6ad9193d22f486b6.camel@linuxfoundation.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <66fb849c-41d7-650a-046c-bc09e76fd594@siemens.com>
Date: Tue, 4 Sep 2018 15:09:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
	Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <f22cc8eccc5b47a29c87de3b6ad9193d22f486b6.camel@linuxfoundation.org>
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
X-List-Received-Date: Tue, 04 Sep 2018 13:23:58 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2018-09-04 14:34, Richard Purdie wrote:
> On Tue, 2018-09-04 at 13:15 +0100, Richard Purdie wrote:
>> On Sun, 2018-09-02 at 10:43 +0200, Jan Kiszka wrote:
>>> We need to print exceptions and flush output channels before
>>> telling
>>> the
>>> client that the server failed. Otherwise the daemon log file may
>>> still
>>> be empty when the client opens it for printing.
>>>
>>> This fixes error reporting when the output is redirected to a pipe,
>>> e.g.
>>> "bitbake target | cat" with a syntax error in a recipes or config
>>> file.
>>> That's specifically annoying when bitbake is under the control of a
>>> frontend process such as kas.
>>
>> Hi,
>>
>> Could you check if this was already fixed by:
>>
>> http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=cbe2d3cb0af6c7a5
>> cd368e7dc489960a13648bd0

Looks similar on first glance, but it only partly helps with exceptions. 
We get from

$ bitbake | cat
ERROR: Unable to start bitbake server

to

$ bitbake | cat
ERROR: Unable to start bitbake server
ERROR: Server log for this session (/work/build/bitbake-cookerdaemon.log):
--- Starting bitbake server pid 149 at 2018-09-04 13:02:15.144583 ---

while it should have

$ bitbake
ERROR: Unable to start bitbake server
ERROR: Last 10 lines of server log for this session 
(/work/build/bitbake-cookerdaemon.log):
Traceback (most recent call last):
   File "/work/isar/bitbake/lib/bb/daemonize.py", line 77, in createDaemon
     function()
   File "/work/isar/bitbake/lib/bb/server/process.py", line 433, in 
_startServer
     self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
   File "/work/isar/bitbake/lib/bb/cooker.py", line 178, in __init__
     self.configwatcher = pyinotify.WatchManager()
   File "/work/isar/bitbake/lib/pyinotify.py", line 1764, in __init__
     raise OSError(err % self._inotify_wrapper.str_errno())
OSError: Cannot initialize new instance of inotify, Errno=Too many open 
files (EMFILE)

>>
>> ?
>>
>> I really want to get these flushes as close to the source of the
>> problems as we can.
> 
> Looking at the code further, I suspect we should simply be doing:
> 
>          writer = ConnectionWriter(self.readypipein)
>          self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
>          writer.send("ready")
>          os.close(self.readypipein)
>          server.cooker = self.cooker
> 
> with no exception handling. The ready pipe would then get closed by the
> os._exit() in daemonize which is after the flush. It simplifies the
> code as an added bonus...

Tried that, but it does not work that way, it just hangs.

As I wrote, the test case is trivial: just direct the output of bitbake 
into a pipe (bitbake | cat).

Jan

