Return-Path: <avery.brian@gmail.com>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
	[209.85.213.173])
	by mail.openembedded.org (Postfix) with ESMTP id 048C760118
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Mar 2016 20:28:03 +0000 (UTC)
Received: by mail-ig0-f173.google.com with SMTP id cl4so60822823igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Mar 2016 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc; bh=trbqrA4JZRKiw8GknrIRCv6RGS2mY8298x139sc1zQM=;
	b=TZleNHbAFuM6i9Oml8NAZiwP54yFzcaQsDr/IJ/MOlGmzqL2Bia38DnmemOBez/RcO
	UQ0Y+OdTKjTIqVjZ6QIbnORQN7x/5FIRmPB+ikqCQSeiYs3kxhu6O3zWgzQInxRxMrtz
	CD3Sj46nPniXotHuNpULvU0TI0w8FdDr+zVxz60aqnV1eu8LBCtLps2v/2jl2LKhfhwc
	mddnnwCCw5sVaCm0c/Ij525uy2/aRDYC/PLS+rCx8rz7wGAg0ASCgekKGOTplvYJ0kR4
	7LmSFBiKGamBpUgH5QAti3f4xjIeIc8eCHg66AZDOeiYJ0w0/h2Gz/x11mqidR4bMpWJ
	qrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc;
	bh=trbqrA4JZRKiw8GknrIRCv6RGS2mY8298x139sc1zQM=;
	b=ggPO/gP1z3NcNY0hwfsIgAm/Etb5pTlvwBBCuZnPItc7/UoOfEVKb3TEDWGdKhBfJ2
	csVez+9wuGbJo3rrpLZ6HC8o3lEZs1Yr+YIx0Ilh1Q/ZntB2CziYsenjgPQD3b1HZ7PI
	x3kRb25Ae66QS2OvUGTlqkDlvR7aGMcP5sASd1PedI+MY55ElRZ/72j9F9f0dF+qKXJ3
	vVfGBJgP1JKQDwvuh+rZG2csCl8OHPr8qsPG3kXJfeIX9avb/5aBBotCxUKlxcPNxWPe
	DwYYmqsIxkxNU+dOMayLsyrfaOMEXLwaz7qUPciGiUjaRm6kj4B39oes4XZVhiDrcmpL
	N+PA==
X-Gm-Message-State: AD7BkJLfPS8q68JmFFO30DfnzYRbUKbtfeGnRLIEm4HFt6GCykocd84JhEZhwNV6CaUGVDse/F1enI7kjmybEA==
MIME-Version: 1.0
X-Received: by 10.50.61.232 with SMTP id t8mr11970331igr.83.1459196883989;
	Mon, 28 Mar 2016 13:28:03 -0700 (PDT)
Received: by 10.107.164.77 with HTTP; Mon, 28 Mar 2016 13:28:03 -0700 (PDT)
In-Reply-To: <1458214463-16103-1-git-send-email-elliot.smith@intel.com>
References: <1458214463-16103-1-git-send-email-elliot.smith@intel.com>
Date: Mon, 28 Mar 2016 13:28:03 -0700
Message-ID: <CAKV_0egRF1Ro+26QTbpc5ZoS5u-qvg2D=AWWNGkGXjrwf-+nsg@mail.gmail.com>
From: Brian Avery <avery.brian@gmail.com>
To: Elliot Smith <elliot.smith@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: xmlrpc: set single use mode differently
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
X-List-Received-Date: Mon, 28 Mar 2016 20:28:06 -0000
Content-Type: text/plain; charset=UTF-8

Hi,
The original idea behind this fix was to remove the idea that bitbake
would *ever* autoexit.  If a ui starts up a bitbake server then the
server should remain until it is told to exit. Basically, we were
going to remove the single use flag entirely and fix any (if there are
any) issues in knotty that rely on that behaviour.

Thoughts?,
-b
an intel employee

On Thu, Mar 17, 2016 at 4:34 AM, Elliot Smith <elliot.smith@intel.com> wrote:
> From: Ed Bartosh <ed.bartosh@linux.intel.com>
>
> Currently xmlrpc server implicitly sets itself into single use mode
> when bitbake server is started with anonymous port (0) or no port is
> provided in command line. In this mode bitbake shuts down xmlrpc server
> after build is done. This assumption is incorrect in some cases.
> For example Toaster uses bitbake in this mode and expects xmlrpc server
> to stay in memory.
>
> Till recent changes single use mode was always unset due to the bug.
> When the bug was fixed it broke toaster builds as Toaster couldn't
> communicate with bitbake server in single use mode.
>
> Reimplemented logic of setting single use mode. The mode is explicity
> set when --server-only command line parameter is not provided to bitbake.
> It doesn't depend on the port number anymore.
>
> [YOCTO #9275]
> [YOCTO #9240]
> [YOCTO #9252]
>
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> Signed-off-by: Elliot Smith <elliot.smith@intel.com>
> ---
>  bitbake/lib/bb/main.py           | 5 +++--
>  bitbake/lib/bb/server/process.py | 2 +-
>  bitbake/lib/bb/server/xmlrpc.py  | 8 ++++----
>  3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> index bf59793..a28c751 100755
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -282,12 +282,13 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>
>  def start_server(servermodule, configParams, configuration, features):
>      server = servermodule.BitBakeServer()
> +    single_use = not configParams.server_only
>      if configParams.bind:
>          (host, port) = configParams.bind.split(':')
> -        server.initServer((host, int(port)))
> +        server.initServer((host, int(port)), single_use)
>          configuration.interface = [ server.serverImpl.host, server.serverImpl.port ]
>      else:
> -        server.initServer()
> +        server.initServer(single_use=single_use)
>          configuration.interface = []
>
>      try:
> diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
> index e387b30..a3078a8 100644
> --- a/bitbake/lib/bb/server/process.py
> +++ b/bitbake/lib/bb/server/process.py
> @@ -242,7 +242,7 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
>
>
>  class BitBakeServer(BitBakeBaseServer):
> -    def initServer(self):
> +    def initServer(self, single_use=True):
>          # establish communication channels.  We use bidirectional pipes for
>          # ui <--> server command/response pairs
>          # and a queue for server -> ui event notifications
> diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
> index a79b490..48d45d8 100644
> --- a/bitbake/lib/bb/server/xmlrpc.py
> +++ b/bitbake/lib/bb/server/xmlrpc.py
> @@ -189,12 +189,12 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
>      # remove this when you're done with debugging
>      # allow_reuse_address = True
>
> -    def __init__(self, interface):
> +    def __init__(self, interface, single_use=False):
>          """
>          Constructor
>          """
>          BaseImplServer.__init__(self)
> -        self.single_use = interface[1] == 0 # anonymous port, not getting reused
> +        self.single_use = single_use
>          # Use auto port configuration
>          if (interface[1] == -1):
>              interface = (interface[0], 0)
> @@ -335,9 +335,9 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
>              pass
>
>  class BitBakeServer(BitBakeBaseServer):
> -    def initServer(self, interface = ("localhost", 0)):
> +    def initServer(self, interface = ("localhost", 0), single_use = False):
>          self.interface = interface
> -        self.serverImpl = XMLRPCServer(interface)
> +        self.serverImpl = XMLRPCServer(interface, single_use)
>
>      def detach(self):
>          daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
> --
> 1.9.3
>
> ---------------------------------------------------------------------
> Intel Corporation (UK) Limited
> Registered No. 1134945 (England)
> Registered Office: Pipers Way, Swindon SN3 1RJ
> VAT No: 860 2173 47
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

