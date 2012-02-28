Received: from mail.dream-property.net ([82.149.226.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <obi@opendreambox.org>) id 1S2Q78-0006iF-1G
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 17:41:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.dream-property.net (Postfix) with ESMTP id 6B46731597F7;
	Tue, 28 Feb 2012 17:32:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.dream-property.net
Received: from mail.dream-property.net ([127.0.0.1])
	by localhost (mail.dream-property.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id fgJhNV1fHfa2; Tue, 28 Feb 2012 17:32:42 +0100 (CET)
Received: from [172.22.22.61] (drms-590c5704.pool.mediaWays.net [89.12.87.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dream-property.net (Postfix) with ESMTPSA id 3DA2C31597F1;
	Tue, 28 Feb 2012 17:32:42 +0100 (CET)
Message-ID: <4F4D01A9.1010303@opendreambox.org>
Date: Tue, 28 Feb 2012 17:32:41 +0100
From: Andreas Oberritter <obi@opendreambox.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <4F4CC00F.10608@opendreambox.org> <1330430595.9185.109.camel@ted>
In-Reply-To: <1330430595.9185.109.camel@ted>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Git, AUTOREV and SSH
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 28 Feb 2012 16:41:22 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.02.2012 13:03, Richard Purdie wrote:
> On Tue, 2012-02-28 at 12:52 +0100, Andreas Oberritter wrote:
>> Hi,
>>
>> there's a problem with the Git fetcher when used with AUTOREV, at least
>> with SSH URIs. "git ls-remote" may output warnings on stderr, e.g.:
>>
>> X11 forwarding request failed on channel 0
>>
>> When this happens, "X11" becomes the SRCREV and the fetcher subsequently
>> fails. Certainly, other warnings by Git, SSH or a different SCM or
>> transport could appear under other circumstances. Even localized strings
>> may appear. Fetch2 merges stderr into stdout on purpose [1], so I'm not
>> sure a proper fix should look like.
>>
>> Regards,
>> Andreas
>>
>> [1] See runfetchcmd() in lib/bb/fetch2/__init__.py
> 
> Would the change in
> http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-January/001771.html help?
> 
> I've still not had a chance to rebase and apply that patch :(

Yes, this patch did help. See below for a rebased version. Thanks!

Regards,
Andreas

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 07aac4c..42fef69 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -392,6 +392,9 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
     Optionally remove the files/directories listed in cleanup upon failure
     """
 
+    import bb.process
+    import subprocess
+
     # Need to export PATH as binary could be in metadata paths
     # rather than host provided
     # Also include some other variables.
@@ -409,36 +412,27 @@ def runfetchcmd(cmd, d, quiet = False, cleanup = []):
 
     logger.debug(1, "Running %s", cmd)
 
-    # redirect stderr to stdout
-    stdout_handle = os.popen(cmd + " 2>&1", "r")
-    output = ""
-
-    while True:
-        line = stdout_handle.readline()
-        if not line:
-            break
-        if not quiet:
-            print(line, end=' ')
-        output += line
-
-    status = stdout_handle.close() or 0
-    signal = os.WTERMSIG(status)
-    if os.WIFEXITED(status):
-        exitstatus = os.WEXITSTATUS(status)
-    else:
-        exitstatus = 0
+    success = False
+    error_message = ""
+
+    try:
+        (output, errors) = bb.process.run(cmd, shell=True, stderr=subprocess.PIPE)
+        success = True
+    except bb.process.NotFoundError as e:
+        error_message = "Fetch command %s" % (e.command)
+    except bb.process.CmdError as e:
+        error_message = "Fetch command %s could not be run:\n%s" % (e.command, e.msg)
+    except bb.process.ExecutionError as e:
+        error_message = "Fetch command %s failed with exit code %s, output:\n%s" % (e.command, e.exitcode, e.stderr)
 
-    if (signal or status != 0):
+    if not success:
         for f in cleanup:
             try:
                 bb.utils.remove(f, True)
             except OSError:
                 pass
 
-        if signal:
-            raise FetchError("Fetch command %s failed with signal %s, output:\n%s" % (cmd, signal, output))
-        elif exitstatus:
-            raise FetchError("Fetch command %s failed with exit code %s, output:\n%s" % (cmd, exitstatus, output))
+        raise FetchError(error_message)
 
     return output
 


