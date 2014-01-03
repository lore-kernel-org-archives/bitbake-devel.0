Return-Path: <jason.wessel@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id B290E6B6C7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jan 2014 14:19:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s03EJbce022821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 3 Jan 2014 06:19:37 -0800 (PST)
Received: from [172.25.32.36] (172.25.32.36) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Fri, 3 Jan 2014 06:19:37 -0800
Message-ID: <52C6C6F9.70007@windriver.com>
Date: Fri, 3 Jan 2014 08:19:37 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: "Damian, Alexandru" <alexandru.damian@intel.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com>
In-Reply-To: <CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com>
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
X-List-Received-Date: Fri, 03 Jan 2014 14:19:40 -0000
Content-Type: multipart/alternative;
	boundary="------------030804060801050407070700"

--------------030804060801050407070700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 01/03/2014 07:09 AM, Damian, Alexandru wrote:
> Hi Jason,
>
> I noticed that this patch *oe-init-build-env: Allow startup with and without memres* will kill any existing bitbake server when oe-init-build-env is started. I think this always happens since I see no way to source oe-init-build-env when BBSERVER is set.
>
> I'm trying to figure out a better solution, since simply stopping the server will leave toaster in an inconsistent state, if the server was started through toaster.
>
> Can you please tell me what behaviour are you trying to get out of the system ? Let's try to find something that will also work for Toaster.


It seems to me there must be a corner case, which should be easy enough to fix.  If the BBSERVER is set, it should simply attach to the existing instance, assuming the instance is reachable.  There is some code that was added to validate the bitbake server instance is healthy or it will get shutdown.

Do you have a step by step set of instructions to duplicate the behavior you are inquiring about or a bugzilla case I can take a peek at?

Thanks,
Jason.

--------------030804060801050407070700
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 01/03/2014 07:09 AM, Damian,
      Alexandru wrote:<br>
    </div>
    <blockquote
cite="mid:CAJ2CSBtesiTjc-0m6jSVwuTX0QZto=YgXNH0UzoZFc6qPK=M0g@mail.gmail.com"
      type="cite">
      <meta http-equiv="Context-Type" content="text/html; charset=UTF-8">
      <div dir="ltr">Hi Jason,
        <div><br>
        </div>
        <div>I noticed that this patch *oe-init-build-env: Allow startup
          with and without memres* will kill any existing bitbake server
          when oe-init-build-env is started. I think this always happens
          since I see no way to source oe-init-build-env when BBSERVER
          is set.</div>
        <div><br>
        </div>
        <div>I'm trying to figure out a better solution, since simply
          stopping the server will leave toaster in an inconsistent
          state, if the server was started through toaster.</div>
        <div><br>
        </div>
        <div>Can you please tell me what behaviour are you trying to get
          out of the system ? Let's try to find something that will also
          work for Toaster.</div>
      </div>
    </blockquote>
    <br>
    <br>
    It seems to me there must be a corner case, which should be easy
    enough to fix.  If the BBSERVER is set, it should simply attach to
    the existing instance, assuming the instance is reachable.  There is
    some code that was added to validate the bitbake server instance is
    healthy or it will get shutdown.<br>
    <br>
    Do you have a step by step set of instructions to duplicate the
    behavior you are inquiring about or a bugzilla case I can take a
    peek at?<br>
    <br>
    Thanks,<br>
    Jason.<br>
  </body>
</html>

--------------030804060801050407070700--
