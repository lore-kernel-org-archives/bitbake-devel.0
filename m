Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic305-21.consmr.mail.sg3.yahoo.com
	(sonic305-21.consmr.mail.sg3.yahoo.com [106.10.241.84])
	by mail.openembedded.org (Postfix) with ESMTP id 5CB9A60119
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 May 2018 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1526610338; bh=tJsuLkw9ypym4AgqUDUduZp3mVZyDdiIcA8T2GeZSHk=;
	h=Date:From:To:Subject:References:From:Subject;
	b=mMEb9nl7zOVagS4DUN/i3isn2CRzuub15zINxxQ0nAU6b+yd+jwp9f+9rWH2+xBtHXZX/LeMCDgEOR4lGGErRvJaK9YA47ijwXSTq+qL6rUGxmfubxMFuGyf7TO4UvltsZOKNRQuKPn23pa8j40vkNUHGveS0JuvvHOO5m+wY2CZiTrnPxgDdsPwrvOgguht7fv1gCspwCTVgfHjooSO4efEriOrQXXJPIIyXlGgM9/Z/GjsU9EE6mr7/551So7tWUwz/pzGkCXhzphX2v/zMUrdJH0XeF3dLAWhmv740JaK59mlS2hF+9uVbYgsRlF+o+PRPtxJl7jOjhxSNZu01g==
X-YMail-OSG: jmCtcusVM1k4AyjMtY08HkCRQNIonhUQ2.DhBO0bl_L92MkU8XMFP0yeg1i8ARk
	xcbZw0FUo6vqSZuk_5Fm1Y8Gmb9kxrc5t4CgGSRDRDzojaKwIUBQe2FGf7w1eShCCWkue83r_xI9
	AOcWWZeTAnfk1P5Ebrcp5OHQNA7zCKOr_pFr20QhpVqVtMeqiR9d6qLIXuxpdzr31PEXEnFZbSWx
	b21GFZ.Z1KLGKlqn_BioM7AbZImruy468vN5qqdQ4PO2lUlLz4Ffj_RMqeIEjKxNPv9wRGoZrygi
	kEWeFQJ_Jqnv_6bswAQLRMtTRCBz9D0iWH2hWXxEWmE1Hqc5aiykLCRp8c67axIs8sWrljYVhvL4
	4Ive3ELKppENbsTOcpONYnEQP2qArrwRsA9iAUWKLVDI6cpMvUuqiDfU4pj.IpMFktVTLSomhQtI
	QGGN0VVrp0cpovzEe8D46oTH8ck1GbXqVOwwMlncfBnmdoeVVXBlWuQDUohH18dfXdCUDoN7TS8p
	tjdpuSAh0Us.bLnDDG2AHJC36Touz0FHpjH2X4VixYg_2YwI5CU_aAyXphcYj7dX1Rh.4uJ05sep
	qvzyMpZI9fE1ryQKsHapynpYN2YQ38kNEW0popPREHohQJKlWeQ6sOf4YhA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic305.consmr.mail.sg3.yahoo.com with HTTP;
	Fri, 18 May 2018 02:25:38 +0000
Date: Fri, 18 May 2018 02:25:37 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <1212444255.2663200.1526610337781@mail.yahoo.com>
MIME-Version: 1.0
References: <1212444255.2663200.1526610337781.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.11871 YMailNorrin Mozilla/5.0 (X11;
	Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu
	Chromium/64.0.3282.167 Chrome/64.0.3282.167 Safari/537.36
Subject: Enabling the recipe from menuconfig
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
X-List-Received-Date: Fri, 18 May 2018 02:25:38 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_2663199_914781091.1526610337778"

------=_Part_2663199_914781091.1526610337778
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hello Team,

=C2=A0I have a list of recipes in my custom layer. The recipes in this=C2=
=A0layer shall be enabled/selected through the menuconfig, how to bring the=
 recipes in menuconfig? once it is enabled then it shall be the part of ima=
ge. is it possible to achieve=C2=A0it ? do we have any references?=C2=A0
Regards,Ugesh =20

------=_Part_2663199_914781091.1526610337778
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"><div style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"><div></div>
            <div><span style="font-size: small; color: rgb(38, 40, 42);">Hello Team,</span><br></div></div><div id="ydpee85f505yahoo_quoted_7371390324" class="ydpee85f505yahoo_quoted"><div style="font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:13px;color:#26282a;"><div><div id="ydpee85f505yiv5112310628"><div style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:16px;"><div><font size="2"><br></font></div><div><font size="2">&nbsp;I have a list of recipes in my custom layer. The recipes in this&nbsp;layer shall be enabled/selected through the menuconfig, how to bring the recipes in menuconfig? once it is enabled then it shall be the part of image. is it possible to achieve&nbsp;it ? do we have any references?&nbsp;</font></div><div><font size="2"><br></font></div><div><font size="2">Regards,</font></div><div><font size="2">Ugesh</font></div></div></div></div>
                </div>
            </div></div></body></html>

------=_Part_2663199_914781091.1526610337778--
