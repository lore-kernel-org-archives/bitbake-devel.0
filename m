Return-Path: <S.Mueller-Klieser@phytec.de>
X-Greylist: delayed 477 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 27 Feb 2015 16:00:38 UTC
Received: from root.phytec.de (mail.x-arc.de [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 75D45737E7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 16:00:38 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 2305AA0010B;
	Fri, 27 Feb 2015 16:53:33 +0100 (CET)
In-Reply-To: <CAGpdKUJbZ=hdXW2MLMr3wcK98JYDQnPJ8mxVxzW1v4q2hcK_qg@mail.gmail.com>
References: <CAGpdKUJbZ=hdXW2MLMr3wcK98JYDQnPJ8mxVxzW1v4q2hcK_qg@mail.gmail.com>
To: Roman Savchenko <gmstima@gmail.com>
MIME-Version: 1.0
X-KeepSent: CE633C5D:56550AF3-C1257DF9:0056EE90;
 type=4; name=$KeepSent
X-Mailer: IBM Notes Release 9.0.1 October 14, 2013
Message-ID: <OFCE633C5D.56550AF3-ONC1257DF9.0056EE90-C1257DF9.005738E9@phytec.de>
From: =?ISO-8859-1?Q?Stefan_M=FCller-Klieser?= <S.Mueller-Klieser@phytec.de>
Date: Fri, 27 Feb 2015 16:52:42 +0100
X-MIMETrack: Serialize by Router on Idefix/Phytec(Release 9.0.1FP2
	HF590|December 11, 2014) at 27.02.2015 16:52:42,
	Serialize complete at 27.02.2015 16:52:42
Cc: bitbake-devel@lists.openembedded.org
Subject: Antwort: Run postscript
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
X-List-Received-Date: Fri, 27 Feb 2015 16:00:40 -0000
Content-Type: text/plain; charset="US-ASCII"

Hi Roman,

I suppose you work with poky, then maybe this is what you are looking for:
http://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var-ROOTFS_POSTPROCESS_COMMAND

Regards,
Stefan

bitbake-devel-bounces@lists.openembedded.org wrote on 02/27/2015 04:33:38 
PM:

> Von: Roman Savchenko <gmstima@gmail.com>
> An: bitbake-devel@lists.openembedded.org
> Datum: 02/27/2015 04:34 PM
> Betreff: [bitbake-devel] Run postscript
> Gesendet von: bitbake-devel-bounces@lists.openembedded.org
> 
> Hi all,

> does bitbake have post-build-triggers? Where can I read about it?

> Many thanks for help.
> 
> Regards,
> R. Savchnko-- 
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


