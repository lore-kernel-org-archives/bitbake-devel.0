Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 7255376EA4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 18:16:18 +0000 (UTC)
Received: by pabzx8 with SMTP id zx8so147003863pab.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Aug 2015 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=CplJ6rjIfFhrkv54/OclNTnVhcSiNwa7kMlJ2YKBgyo=;
	b=Tu9SjMita/wQQziANAEL9+XE10sBU2Z1jkm8BQdaUvJf5K9VKOMB8/mV4S4GG07NHA
	89wk1nQkJVKwq+VHb5IND67Td2Q6f/xIiF79HyWzZ2n/NwNPdodpXzRKxqH7nB7xUIBR
	yoVk+THPb/Kuz+Bqx5dXahAn+XMIKIRXrgPpzlmuTpBICDStdkiE9zwxBNoAevKK1joi
	NoEt4eDfcq9gpfLPL2Mwf05E3ikBsWjnxW4w8igAmf2aoOg/Z+d+bQr8imbw+3SfrUAd
	iQyVhG0sIazk1DoW410GkyS9bZgZkOqJzVIRi3+Y8o9lUiLcGuEwEcHMuRXo00WhBnEn
	cbgQ==
X-Received: by 10.68.191.130 with SMTP id gy2mr40151838pbc.124.1441044978847; 
	Mon, 31 Aug 2015 11:16:18 -0700 (PDT)
Received: from [10.22.11.207] (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
	by smtp.googlemail.com with ESMTPSA id
	fb4sm14649416pdb.32.2015.08.31.11.16.17
	(version=TLSv1/SSLv3 cipher=OTHER);
	Mon, 31 Aug 2015 11:16:17 -0700 (PDT)
Message-ID: <55E499EF.8050809@gmail.com>
Date: Mon, 31 Aug 2015 11:16:15 -0700
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Saul Wold <sgw@linux.intel.com>, 
 bitbake-devel@lists.openembedded.org
References: <1440778096-16982-1-git-send-email-sgw@linux.intel.com>
	<55E08E84.90603@mvista.com> <55E14E5A.5040109@linux.intel.com>
In-Reply-To: <55E14E5A.5040109@linux.intel.com>
Cc: paul.eggleton@linux.intel.com
Subject: Re: [PATCH][1.24/dizzy] cooker: properly fix bitbake.lock handling
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
X-List-Received-Date: Mon, 31 Aug 2015 18:16:22 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 08/28/2015 11:16 PM, Saul Wold wrote:
> On 08/28/2015 09:38 AM, akuster wrote:
>> Saul,
>>
>> This isn't applying for me. what commits in Dizzy does this depend on?
>>
>> I rebased my branch on both dizzy and dizzy-next and get the same errors.
>>
>>
>> URL:http://patches.openembedded.org/patch/101957/mbox/ [9582] ->
>> "pw-am-101957.patch" [1]
>> Applying: cooker: properly fix bitbake.lock handling
>> error: bin/bitbake: does not exist in index
>> error: lib/bb/cooker.py: does not exist in index
>> error: lib/bb/tinfoil.py: does not exist in index
>> error: lib/bb/ui/knotty.py: does not exist in index
>> error: lib/bb/utils.py: does not exist in index
>> Patch failed at 0001 cooker: properly fix bitbake.lock handling
>>
>>
>> Am I doing something wrong?
>>
> Yeah, this applies to bitbake and then RP will merge it with your
> oe-core based patches to create a poky base.  I have this patch in my
> poky-contrib/sgw/dizzy branch.
> 

Ah, ok.. thanks

- armin
> Sau!
> 
>> - armin
>>
>>
>> On 08/28/2015 09:08 AM, Saul Wold wrote:
>>> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>>>
>>> If the PR server or indeed any other child process takes some time to
>>> exit (which it sometimes does when saving its database), it can end up
>>> holding bitbake.lock after the UI exits, which led to errors if you ran
>>> bitbake commands successively - we saw this when running the PR server
>>> oe-selftest tests in OE-Core. The recent attempt to fix this wasn't
>>> quite right and ended up breaking memory resident bitbake. This time we
>>> close the lock file when cooker shuts down (inside the UI process)
>>> instead of unlocking it, and this is done in the cooker code rather than
>>> the actual UI code so it doesn't matter which UI is in use. Additionally
>>> we report that we're waiting for the lock to be released, using lsof or
>>> fuser if available to list the processes with the lock open.
>>>
>>> The 'magic' in the locking is due to all spawned subprocesses of bitbake
>>> holding an open file descriptor to the bitbake.lock. It is automatically
>>> unlocked when all those fds close the file (as all the processes
>>> terminate).
>>> We close the UI copy of the lock explicitly, then close the server
>>> process
>>> copy, any remaining open copy is therefore some proess exiting.
>>>
>>> (The reproducer for the problem is to set PRSERV_HOST = "localhost:0"
>>> and add a call to time.sleep(20) after self.server_close() in
>>> lib/prserv/serv.py, then run "bitbake -p; bitbake -p" ).
>>>
>>> Cleanup work done by Paul Eggleton <paul.eggleton@linux.intel.com>.
>>>
>>> This reverts bitbake commit 69ecd15aece54753154950c55d7af42f85ad8606 and
>>> e97a9f1528d77503b5c93e48e3de9933fbb9f3cd.
>>>
>>> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> (cherry picked from commit a29780bd43f74b7326fe788dbd65177b86806fcf)
>>>
>>> [sgw - added cooker.lock.close() to bin/bitbake as we don't use
>>> main.py in 1.24]
>>> Signed-off-by: Saul Wold <sgw@linux.intel.com>
>>>
>>> Conflicts:
>>>     lib/bb/cooker.py
>>>     lib/bb/main.py
>>>     lib/bb/tinfoil.py
>>>     lib/bb/ui/knotty.py
>>> ---
>>>   bin/bitbake         |  1 +
>>>   lib/bb/cooker.py    | 29 +++++++++++++++++++++++++++++
>>>   lib/bb/tinfoil.py   |  5 +++++
>>>   lib/bb/ui/knotty.py | 43 ++++++++++++++++++++++++-------------------
>>>   lib/bb/utils.py     | 29 +++++++++++++++++++++++++----
>>>   5 files changed, 84 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/bin/bitbake b/bin/bitbake
>>> index a2e8cc1..32120e7 100755
>>> --- a/bin/bitbake
>>> +++ b/bin/bitbake
>>> @@ -263,6 +263,7 @@ def start_server(servermodule, configParams,
>>> configuration, features):
>>>                   logger.handle(event)
>>>           raise exc_info[1], None, exc_info[2]
>>>       server.detach()
>>> +    cooker.lock.close()
>>>       return server
>>>
>>>
>>> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
>>> index aeb3f71..70cccef 100644
>>> --- a/lib/bb/cooker.py
>>> +++ b/lib/bb/cooker.py
>>> @@ -38,6 +38,8 @@ import bb, bb.exceptions, bb.command
>>>   from bb import utils, data, parse, event, cache, providers,
>>> taskdata, runqueue
>>>   import Queue
>>>   import signal
>>> +import subprocess
>>> +import errno
>>>   import prserv.serv
>>>   import pyinotify
>>>
>>> @@ -1442,6 +1444,33 @@ class BBCooker:
>>>       def post_serve(self):
>>>           prserv.serv.auto_shutdown(self.data)
>>>           bb.event.fire(CookerExit(), self.event_data)
>>> +        lockfile = self.lock.name
>>> +        self.lock.close()
>>> +        self.lock = None
>>> +
>>> +        while not self.lock:
>>> +            with bb.utils.timeout(3):
>>> +                self.lock = bb.utils.lockfile(lockfile,
>>> shared=False, retry=False, block=True)
>>> +                if not self.lock:
>>> +                    # Some systems may not have lsof available
>>> +                    procs = None
>>> +                    try:
>>> +                        procs = subprocess.check_output(["lsof",
>>> '-w', lockfile], stderr=subprocess.STDOUT)
>>> +                    except OSError as e:
>>> +                        if e.errno != errno.ENOENT:
>>> +                            raise
>>> +                    if procs is None:
>>> +                        # Fall back to fuser if lsof is unavailable
>>> +                        try:
>>> +                            procs =
>>> subprocess.check_output(["fuser", '-v', lockfile],
>>> stderr=subprocess.STDOUT)
>>> +                        except OSError as e:
>>> +                            if e.errno != errno.ENOENT:
>>> +                                raise
>>> +
>>> +                    msg = "Delaying shutdown due to active processes
>>> which appear to be holding bitbake.lock"
>>> +                    if procs:
>>> +                        msg += ":\n%s" % str(procs)
>>> +                    print(msg)
>>>
>>>       def shutdown(self, force = False):
>>>           if force:
>>> diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
>>> index 6bcbd47..277131f 100644
>>> --- a/lib/bb/tinfoil.py
>>> +++ b/lib/bb/tinfoil.py
>>> @@ -84,6 +84,11 @@ class Tinfoil:
>>>               else:
>>>                   self.parseRecipes()
>>>
>>> +    def shutdown(self):
>>> +        self.cooker.shutdown(force=True)
>>> +        self.cooker.post_serve()
>>> +        self.cooker.unlockBitbake()
>>> +
>>>   class TinfoilConfigParameters(ConfigParameters):
>>>
>>>       def __init__(self, **options):
>>> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
>>> index 9e58b31..8466455 100644
>>> --- a/lib/bb/ui/knotty.py
>>> +++ b/lib/bb/ui/knotty.py
>>> @@ -536,24 +536,29 @@ def main(server, eventHandler, params, tf =
>>> TerminalFilter):
>>>               if not params.observe_only:
>>>                   _, error = server.runCommand(["stateForceShutdown"])
>>>               main.shutdown = 2
>>> -    summary = ""
>>> -    if taskfailures:
>>> -        summary += pluralise("\nSummary: %s task failed:",
>>> -                             "\nSummary: %s tasks failed:",
>>> len(taskfailures))
>>> -        for failure in taskfailures:
>>> -            summary += "\n  %s" % failure
>>> -    if warnings:
>>> -        summary += pluralise("\nSummary: There was %s WARNING
>>> message shown.",
>>> -                             "\nSummary: There were %s WARNING
>>> messages shown.", warnings)
>>> -    if return_value and errors:
>>> -        summary += pluralise("\nSummary: There was %s ERROR message
>>> shown, returning a non-zero exit code.",
>>> -                             "\nSummary: There were %s ERROR
>>> messages shown, returning a non-zero exit code.", errors)
>>> -    if summary:
>>> -        print(summary)
>>> -
>>> -    if interrupted:
>>> -        print("Execution was interrupted, returning a non-zero exit
>>> code.")
>>> -        if return_value == 0:
>>> -            return_value = 1
>>> +    try:
>>> +        summary = ""
>>> +        if taskfailures:
>>> +            summary += pluralise("\nSummary: %s task failed:",
>>> +                                 "\nSummary: %s tasks failed:",
>>> len(taskfailures))
>>> +            for failure in taskfailures:
>>> +                summary += "\n  %s" % failure
>>> +        if warnings:
>>> +            summary += pluralise("\nSummary: There was %s WARNING
>>> message shown.",
>>> +                                 "\nSummary: There were %s WARNING
>>> messages shown.", warnings)
>>> +        if return_value and errors:
>>> +            summary += pluralise("\nSummary: There was %s ERROR
>>> message shown, returning a non-zero exit code.",
>>> +                                 "\nSummary: There were %s ERROR
>>> messages shown, returning a non-zero exit code.", errors)
>>> +        if summary:
>>> +            print(summary)
>>> +
>>> +        if interrupted:
>>> +            print("Execution was interrupted, returning a non-zero
>>> exit code.")
>>> +            if return_value == 0:
>>> +                return_value = 1
>>> +    except IOError as e:
>>> +        import errno
>>> +        if e.errno == errno.EPIPE:
>>> +            pass
>>>
>>>       return return_value
>>> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>>> index 2562db8..f217ae3 100644
>>> --- a/lib/bb/utils.py
>>> +++ b/lib/bb/utils.py
>>> @@ -31,6 +31,7 @@ import subprocess
>>>   import glob
>>>   import traceback
>>>   import errno
>>> +import signal
>>>   from commands import getstatusoutput
>>>   from contextlib import contextmanager
>>>
>>> @@ -386,10 +387,30 @@ def fileslocked(files):
>>>       for lock in locks:
>>>           bb.utils.unlockfile(lock)
>>>
>>> -def lockfile(name, shared=False, retry=True):
>>> +@contextmanager
>>> +def timeout(seconds):
>>> +    def timeout_handler(signum, frame):
>>> +        pass
>>> +
>>> +    original_handler = signal.signal(signal.SIGALRM, timeout_handler)
>>> +
>>> +    try:
>>> +        signal.alarm(seconds)
>>> +        yield
>>> +    finally:
>>> +        signal.alarm(0)
>>> +        signal.signal(signal.SIGALRM, original_handler)
>>> +
>>> +def lockfile(name, shared=False, retry=True, block=False):
>>>       """
>>> -    Use the file fn as a lock file, return when the lock has been
>>> acquired.
>>> -    Returns a variable to pass to unlockfile().
>>> +    Use the specified file as a lock file, return when the lock has
>>> +    been acquired. Returns a variable to pass to unlockfile().
>>> +    Parameters:
>>> +        retry: True to re-try locking if it fails, False otherwise
>>> +        block: True to block until the lock succeeds, False otherwise
>>> +    The retry and block parameters are kind of equivalent unless you
>>> +    consider the possibility of sending a signal to the process to
>>> break
>>> +    out - at which point you want block=True rather than retry=True.
>>>       """
>>>       dirname = os.path.dirname(name)
>>>       mkdirhier(dirname)
>>> @@ -402,7 +423,7 @@ def lockfile(name, shared=False, retry=True):
>>>       op = fcntl.LOCK_EX
>>>       if shared:
>>>           op = fcntl.LOCK_SH
>>> -    if not retry:
>>> +    if not retry and not block:
>>>           op = op | fcntl.LOCK_NB
>>>
>>>       while True:
>>>
>>

