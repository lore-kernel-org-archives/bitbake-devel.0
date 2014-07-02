Return-Path: <pandey_himanshu80@rediffmail.com>
Received: from f4mail-83-110.rediffmail.com (unknown [203.199.83.110])
	by mail.openembedded.org (Postfix) with ESMTP id 8F7956AD02
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Jul 2014 07:36:31 +0000 (UTC)
Received: from rediffmail.com (unknown [10.50.250.70])
	by f4mail-83-110.rediffmail.com (Postfix) with SMTP id C5CAE3082032
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Jul 2014 12:57:42 +0530 (IST)
Received: (qmail 25688 invoked by uid 510); 2 Jul 2014 07:36:05 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=redf; d=rediffmail.com;
	b=gy2gPS6kdm7KNHRx64jTUj4JOXA+/cehOX+86RfOxFJRGKwXKQow21S5D1/pLUz+d9rWGUwcS0i24ZnGfxlk6NP9ho74l7j1w8PP2di6JMt/haBRpHBYh4wq3r1va56nPCyvsERZKNO5MF+3rtRSAU3ffF/P7KJC5eu4lkjbEz0=
	; 
x-m-msg: asd54ad564ad7aa6sd5as6d5; a6da7d6asas6dasd77; 5dad65ad5sd;
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: : 0
X-CTCH-RefID: str=0001.0A150202.53B3B665.010C, ss=1, re=0.000, recu=0.000,
	reip=0.000, cl=1, cld=1, fgs=0
X-REDF-OSEN: pandey_himanshu80@rediffmail.com
Date: 2 Jul 2014 07:36:04 -0000
Message-ID: <20140702073604.25636.qmail@f4mail-235-146.rediffmail.com>
MIME-Version: 1.0
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Received: from unknown 103.25.205.2 by rediffmail.com via HTTP;
	02 Jul 2014 07:36:04 -0000
Sender: pandey_himanshu80@rediffmail.com
From: "Himanshu  Pandey" <pandey_himanshu80@rediffmail.com>
Subject: Regarding Net-Snmp package
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
X-List-Received-Date: Wed, 02 Jul 2014 07:36:36 -0000
Content-Type: multipart/alternative;
	boundary="=_5c566bd532233981903c27b21fda2b18"

--=_5c566bd532233981903c27b21fda2b18
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

Hi,

I am getting following errors:

Error: net-snmp not found in the base feeds (genericx86_64 x86_64 noarch any all).

sed: can't read /home/yocto/poky-dora-10.0.0/build/tmp/work/x86_64-poky-linux/net-snmp/5.7.2-r1/image/usr/bin/net-snmp-config: No such file or directory

Please help.

Regards,
Himanshu


--=_5c566bd532233981903c27b21fda2b18
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

Hi,<br><br>I am getting following errors:<br><br>Error: net-snmp not found =
in the base feeds (genericx86_64 x86_64 noarch any all).<br><br>sed: can't =
read /home/yocto/poky-dora-10.0.0/build/tmp/work/x86_64-poky-linux/net-snmp=
/5.7.2-r1/image/usr/bin/net-snmp-config: No such file or directory<br><br>P=
lease help.<br><br>Regards,<br>Himanshu<br><br><br><A HREF=3D"http://sigads=
.rediff.com/RealMedia/ads/click_nx.ads/www.rediffmail.com/signatureline.htm=
@Middle?" target=3D"_blank"><IMG SRC=3D"http://sigads.rediff.com/RealMedia/=
ads/adstream_nx.ads/www.rediffmail.com/signatureline.htm@Middle"></A><table=
 cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td><div style=3D"font-fami=
ly: Arial, Helvetica, sans-serif; font-size:14px">Get your own <span style=
=3D"padding-bottom: 0px; background-color: #cc0000; padding-left: 3px; padd=
ing-RIGHT: 3px; font-family: Arial, Helvetica, sans-serif; color: #ffffff; =
font-size: 12px; padding-top: 0px"><b>FREE</b></span> website,  <span style=
=3D"padding-bottom: 0px; background-color: #c00; padding-left: 3px; padding=
-RIGHT: 3px; font-family: Arial, Helvetica, sans-serif; color: #ffffff; fon=
t-size: 12px; padding-top: 0px"><b>FREE</b></span> domain &amp; <span style=
=3D"padding-bottom: 0px; background-color: #c00; padding-left: 3px; padding=
-RIGHT: 3px; font-family: Arial, Helvetica, sans-serif; color: #ffffff; fon=
t-size: 12px; padding-top: 0px"><b>FREE</b></span> mobile app with Company =
email. &nbsp;</div></td><td><a href=3D"http://track.rediff.com/click?url=3D=
___http://businessemail.rediff.com/email-ids-for-companies-with-less-than-5=
0-employees?sc_cid=3Dsign-1-10-13___&cmp=3Dhost&lnk=3Dsign-1-10-13&nsrv1=3D=
host" style=3D"font-family: Arial, Helvetica, sans-serif; color: #fff; font=
-size: 14px; color:#0000cc" target=3D"_blank"><b>Know More ></b></a><!-- <i=
n-put type=3D"button" cl-ass=3D"button" on-click=3D"parent.location=3D&#39;=
http://track.rediff.com/click?url=3D___http://businessemail.rediff.com/comp=
any-email-hosting-services?sc_cid=3Dsignature-23-9-13___&amp;cmp=3Dsignatur=
e-23-9-13&amp;lnk=3Dmypagelogout&amp;nsrv1=3Dhost&#39;" value=3D"Know more =
&gt;"> </input> --></td></tr></tbody></table>

--=_5c566bd532233981903c27b21fda2b18--
