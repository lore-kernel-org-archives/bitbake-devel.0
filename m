Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D84CD6BD65
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 14:42:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s03Egafs022987
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 3 Jan 2014 06:42:36 -0800 (PST)
Received: from [172.25.32.36] (172.25.32.36) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Fri, 3 Jan 2014 06:42:36 -0800
Message-ID: <52C6CC5B.1040800@windriver.com>
Date: Fri, 3 Jan 2014 08:42:35 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: "Damian, Alexandru" <alexandru.damian@intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com>
	<52C6C6F9.70007@windriver.com>
In-Reply-To: <52C6C6F9.70007@windriver.com>
X-Enigmail-Version: 1.6
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: about oe-init-build-env: Allow startup with and without memres
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
X-List-Received-Date: Fri, 03 Jan 2014 14:42:39 -0000
X-Groupsio-MsgNum: 4276
Content-Type: multipart/mixed; boundary="------------070704050108000008060104"

--------------070704050108000008060104
Content-Type: multipart/alternative;
	boundary="------------020604020708030007060708"

--------------020604020708030007060708
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 01/03/2014 08:19 AM, Jason Wessel wrote:
> On 01/03/2014 07:09 AM, Damian, Alexandru wrote:
>> Hi Jason,
>>
>> I noticed that this patch *oe-init-build-env: Allow startup with and without memres* will kill any existing bitbake server when oe-init-build-env is started. I think this always happens since I see no way to source oe-init-build-env when BBSERVER is set.
>>
>> I'm trying to figure out a better solution, since simply stopping the server will leave toaster in an inconsistent state, if the server was started through toaster.
>>
>> Can you please tell me what behaviour are you trying to get out of the system ? Let's try to find something that will also work for Toaster.
>
>
> It seems to me there must be a corner case, which should be easy enough to fix.  If the BBSERVER is set, it should simply attach to the existing instance, assuming the instance is reachable.  There is some code that was added to validate the bitbake server instance is healthy or it will get shutdown.
>
> Do you have a step by step set of instructions to duplicate the behavior you are inquiring about or a bugzilla case I can take a peek at?


I took a look at the code, you asked about and I believe the fix is quite simple.


2013-10-04 14:14 Richard Purdie     5cc4d31    ?    if [ -n "$BBSERVER" ]; then
2013-10-04 14:14 Richard Purdie     5cc4d31    ?       unset BBSERVER
2013-10-04 14:14 Richard Purdie     5cc4d31    ?    fi


I had not noticed this environment variable change.  When all the logic for dealing with BBSERVER was moved into the bitbake startup sequence it is no longer needed.  In fact, a bit further down in the in same file there is a check to deal with not killing anything when BBSERVER is set, but if it was already purged by the prior code there in lies the problem.

See the attached patch.

Cheers,
Jason.



--------------020604020708030007060708
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 01/03/2014 08:19 AM, Jason Wessel
      wrote:<br>
    </div>
    <blockquote cite="mid:52C6C6F9.70007@windriver.com" type="cite">
      <meta http-equiv="Context-Type" content="text/html; charset=UTF-8">
      <div class="moz-cite-prefix">On 01/03/2014 07:09 AM, Damian,
        Alexandru wrote:<br>
      </div>
      <blockquote
cite="mid:CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com"
        type="cite">
        <div dir="ltr">Hi Jason,
          <div><br>
          </div>
          <div>I noticed that this patch *oe-init-build-env: Allow
            startup with and without memres* will kill any existing
            bitbake server when oe-init-build-env is started. I think
            this always happens since I see no way to source
            oe-init-build-env when BBSERVER is set.</div>
          <div><br>
          </div>
          <div>I'm trying to figure out a better solution, since simply
            stopping the server will leave toaster in an inconsistent
            state, if the server was started through toaster.</div>
          <div><br>
          </div>
          <div>Can you please tell me what behaviour are you trying to
            get out of the system ? Let's try to find something that
            will also work for Toaster.</div>
        </div>
      </blockquote>
      <br>
      <br>
      It seems to me there must be a corner case, which should be easy
      enough to fix.&nbsp; If the BBSERVER is set, it should simply attach to
      the existing instance, assuming the instance is reachable.&nbsp; There
      is some code that was added to validate the bitbake server
      instance is healthy or it will get shutdown.<br>
      <br>
      Do you have a step by step set of instructions to duplicate the
      behavior you are inquiring about or a bugzilla case I can take a
      peek at?<br>
    </blockquote>
    <br>
    <br>
    I took a look at the code, you asked about and I believe the fix is
    quite simple.<br>
    <br>
    <br>
    2013-10-04 14:14 Richard Purdie&nbsp;&nbsp;&nbsp;&nbsp; 5cc4d31&nbsp;&nbsp;&nbsp; &#9474;&nbsp;&nbsp;&nbsp; if [ -n
    "$BBSERVER" ]; then<br>
    2013-10-04 14:14 Richard Purdie&nbsp;&nbsp;&nbsp;&nbsp; 5cc4d31&nbsp;&nbsp;&nbsp; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unset
    BBSERVER<br>
    2013-10-04 14:14 Richard Purdie&nbsp;&nbsp;&nbsp;&nbsp; 5cc4d31&nbsp;&nbsp;&nbsp; &#9474;&nbsp;&nbsp;&nbsp; fi<br>
    <br>
    <br>
    I had not noticed this environment variable change.&nbsp; When all the
    logic for dealing with BBSERVER was moved into the bitbake startup
    sequence it is no longer needed.&nbsp; In fact, a bit further down in the
    in same file there is a check to deal with not killing anything when
    BBSERVER is set, but if it was already purged by the prior code
    there in lies the problem.<br>
    <br>
    See the attached patch.<br>
    <br>
    Cheers,<br>
    Jason.<br>
    <br>
    <br>
  </body>
</html>

--------------020604020708030007060708--

--------------070704050108000008060104
Content-Type: text/x-diff;
	name="0001-oe-init-build-env-Allow-use-of-BBSERVER-if-it-is-set.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-oe-init-build-env-Allow-use-of-BBSERVER-if-it-is-set.pa";
	filename*1="tch"

From 2372196669c929a6ad041f48c3b45a711eaa73a2 Mon Sep 17 00:00:00 2001
From: Jason Wessel <jason.wessel@windriver.com>
Date: Fri, 3 Jan 2014 08:37:43 -0600
Subject: [PATCH] oe-init-build-env: Allow use of BBSERVER if it is set

After commit d71059c86 (oe-init-build-env: Allow startup with and
without memres), the bitbake server can fully deal with BBSERVER being
set or unset.

The oe-init-build-env should no longer remove BBSERVER from the
environment such that other users such as the toaster may freely set
and use the init scripts.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 oe-init-build-env |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/oe-init-build-env b/oe-init-build-env
index 8ef32f3..78beeec 100755
--- a/oe-init-build-env
+++ b/oe-init-build-env
@@ -35,10 +35,7 @@ else
    else
       OEROOT="`pwd`"
    fi
-   if [ -n "$BBSERVER" ]; then
-      unset BBSERVER
-   fi
-    OEROOT=`readlink -f "$OEROOT"`
+   OEROOT=`readlink -f "$OEROOT"`
    export OEROOT
    . $OEROOT/scripts/oe-buildenv-internal && \
         $OEROOT/scripts/oe-setup-builddir && \
-- 
1.7.9.5


--------------070704050108000008060104--
