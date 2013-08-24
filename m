Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1C5546A964
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 12:40:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCquJu017240 for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 13:52:56 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wAcdAEaJ6w_u for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 13:52:55 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OCqotX017236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 13:52:51 +0100
Message-ID: <1377348038.6762.190.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 24 Aug 2013 13:40:38 +0100
In-Reply-To: <1377346040.6762.186.camel@ted>
References: <1377346040.6762.186.camel@ted>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: Re: [PATCH] process: Improve exit handling and hangs
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
X-List-Received-Date: Sat, 24 Aug 2013 12:40:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

> @@ -203,5 +201,5 @@ class BitBakeServer(BitBakeBaseServer):
>  
>      def establishConnection(self):
>          self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
> -        signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate(force=True))
> +        signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate())
>          return self.connection

FWIW I think this piece of the change *may* make bitbake's handling of
Ctrl+C more robust. I know people have reported problems with that and
the function being called here was full of deadlocks. I'd be interested
in feedback on whether it helps.

Cheers,

Richard


