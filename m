Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 37E6C738AE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 13:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GDMKFW021509; Tue, 16 Aug 2016 14:22:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VRcJzlLImC1O; Tue, 16 Aug 2016 14:22:20 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7GDMEA1021506
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Aug 2016 14:22:15 +0100
Message-ID: <1471353734.20391.106.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?J=E9r=E9my?= Rosen <jeremy.rosen@smile.fr>, Christopher
	Larson <clarson@kergoth.com>, Peter Kjellerstedt
	<peter.kjellerstedt@axis.com>
Date: Tue, 16 Aug 2016 14:22:14 +0100
In-Reply-To: <11041fd5-2248-53b2-a2aa-ffb75331ed24@smile.fr>
References: <1469098538-14867-1-git-send-email-jeremy.rosen@smile.fr>
	<1469098538-14867-2-git-send-email-jeremy.rosen@smile.fr>
	<14c66145ed854a22bac20bcc53769fc1@XBOX02.axis.com>
	<CABcZANnzPGjXXvMqmOiVSG4sTYTk0y5iKRZdpCk9Fg+4DHHqQg@mail.gmail.com>
	<11041fd5-2248-53b2-a2aa-ffb75331ed24@smile.fr>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	=?ISO-8859-1?Q?J=E9r=E9my?= Rosen <jeremy.rosen@openwide.fr>,
	=?ISO-8859-1?Q?J=E9r=E9my?= Rosen <jeremy.rosen@enst-bretagne.fr>
Subject: Re: [PATCH 1/1] add a syntax to clear variable
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
X-List-Received-Date: Tue, 16 Aug 2016 13:26:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2016-08-16 at 12:38 +0200, Jérémy Rosen wrote:
> As Christopher explained, this is an immediate operation.
> I'll look into unit test, I've never looked into this so I'm not sure
> how they work...

If you run "bitbake-selftest" you will see them in action. There is a
way to disable the network tests to make them much faster (see the help
page).

Cheers,

Richard

