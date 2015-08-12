Return-Path: <remi.peuvergne@openwide.fr>
X-Greylist: delayed 301 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 12 Aug 2015 09:29:01 UTC
Received: from zimbra3.corp.accelance.fr (zimbra3.corp.accelance.fr
	[213.162.49.233])
	by mail.openembedded.org (Postfix) with ESMTP id 73B78766E5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 09:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 06CC27F125
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 11:24:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id Yx0YKg95rkOI for <bitbake-devel@lists.openembedded.org>; 
	Wed, 12 Aug 2015 11:23:55 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr
	[213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 2E8427F151
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Aug 2015 11:23:55 +0200 (CEST)
Date: Wed, 12 Aug 2015 11:23:55 +0200 (CEST)
From: =?utf-8?B?UsOpbWk=?= Peuvergne <remi.peuvergne@openwide.fr>
To: bitbake-devel@lists.openembedded.org
Message-ID: <2007448077.5597509.1439371435023.JavaMail.root@openwide.fr>
In-Reply-To: <461580693.5596129.1439370747631.JavaMail.root@openwide.fr>
MIME-Version: 1.0
X-Originating-IP: [213.244.2.19]
X-Mailer: Zimbra 7.2.6_GA_2926 (ZimbraWebClient - FF3.0 (Linux)/7.2.6_GA_2926)
X-Mailman-Approved-At: Mon, 17 Aug 2015 07:36:05 +0000
Subject: Question about python interpreter in methods embedded in recipes
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
X-List-Received-Date: Wed, 12 Aug 2015 09:29:03 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_5597508_101443564.1439371435023"

------=_Part_5597508_101443564.1439371435023
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi everyone ! 

I've been investigating on an issue when building an image, and I gave up doing what I first wanted. 
I'd like to know more about the issue, and possibly suggest an improvement to bitbake... 

The issue is related to "embedded python methods" in recipes. 

In my image recipe, I'm modifying the rootfs (basically to add a hashed password to /etc/shadow), with something like : 

python set_password() { 
<some piece of python script here> 
} 

The thing is, this piece of code is executed by the *host* interpreter, so it depends on the dev machine (in my case I ran into an issue with crypt.mksalt() not being available). 
It would be nice to allow executing this with the *native* interpreter, the one built during the whole image build process. 

I tried inheriting pythonnative, which sets the PYTHON variable the correct way, but it's not used for those methods... 
I guess it's not easy, since it would need to pass the datastore, but I wonder if there's any smart solution to this ? 

Thanks for your help ! 


Remi 


------=_Part_5597508_101443564.1439371435023
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: arial,helvetica,sans-serif; font-size: 12pt; colo=
r: #000000'>Hi everyone !<br><br>I've been investigating on an issue when b=
uilding an image, and I gave up doing what I first wanted.<br>I'd like to k=
now more about the issue, and possibly suggest an improvement to bitbake...=
<br><br>The issue is related to "embedded python methods" in recipes.<br><b=
r>In my image recipe, I'm modifying the rootfs (basically to add a hashed p=
assword to /etc/shadow), with something like :<br><br>python set_password()=
 {<br><span style=3D"white-space:pre">=09</span>&lt;some piece of python sc=
ript here&gt;<br>}<br><br>The thing is, this piece of code is executed by t=
he *host* interpreter, so it depends on the dev machine (in my case I ran i=
nto an issue with crypt.mksalt() not being available).<br>It would be nice =
to allow executing this with the *native* interpreter, the one built during=
 the whole image build process.<br><br>I tried inheriting pythonnative, whi=
ch sets the PYTHON variable the correct way, but it's not used for those me=
thods...<br>I guess it's not easy, since it would need to pass the datastor=
e, but I wonder if there's any smart solution to this ?<br><br>Thanks for y=
our help !<br><br><br>Remi<br><br></div></body></html>

------=_Part_5597508_101443564.1439371435023--
