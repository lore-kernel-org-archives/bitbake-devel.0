Return-Path: <dugaso@Sonatest.com>
X-Greylist: delayed 1922 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 22 Sep 2014 15:40:10 UTC
Received: from smarthost3.mail.uk.easynet.net (smarthost3.mail.uk.easynet.net
	[212.135.6.13])
	by mail.openembedded.org (Postfix) with ESMTP id 15C146B876
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 15:40:10 +0000 (UTC)
Received: from [217.206.231.74] (port=26856 helo=mail.sonatest.com)
	by smarthost3.mail.uk.easynet.net with esmtp (Exim 4.72)
	(envelope-from <dugaso@Sonatest.com>) id 1XW5Dh-0006SU-KD
	for bitbake-devel@lists.openembedded.org;
	Mon, 22 Sep 2014 16:08:06 +0100
Received: from [192.168.128.68] (192.168.128.68) by EXCHANGE.Sonatest.net
	(212.56.87.3) with Microsoft SMTP Server id 14.2.347.0; Mon, 22 Sep 2014
	16:08:06 +0100
Message-ID: <54203B56.5030607@sonatest.com>
Date: Mon, 22 Sep 2014 11:08:06 -0400
From: Olivier Dugas <dugaso@sonatest.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
X-Mailshell-score: 40, threshold=98, smtpSenderIP=212.56.87.3
	utc=<2014-09-22 15:08:08>
X-EXCLAIMER-MD-CONFIG: 7c1584ba-e595-4fa0-82b4-f84c142522ec
Subject: Bitbake do_unpack checksum?
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
X-List-Received-Date: Mon, 22 Sep 2014 15:40:11 -0000
Content-Type: multipart/alternative;
	boundary="------------070701060800080103060908"

--------------070701060800080103060908
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,
[Go to paragraph surrounded by # if in a hurry]

The company I work for is using Yocto (customized version of dylan). We 
recently faced a little problem with bitbake and my google-fu seems to 
be insufficient to solve it.

I know that when SRC_URI of a recipe is changed, the MD5 and SHA sums 
will have to be updated. If not, bitbake will fail with a very verbose 
error telling exactly what are the new checksums so I can easily update 
them in the recipe.

I also know that a tarball of a recipe might change on a server without 
having its version changed. This is a very bad practice but when this 
happen we are dealing with it.

No, the problem we're having is not about these well documented cases. 
The problem is about rotten bits.

You see, we have a recipe (let's call it foo) that need to be build from 
scratch. Bitbake will do_fetch() it, and verify the checksums. 
Everything's fine, the tarball is saved in the yocto's downloads folder. 
Bitbake then do_unpack() the tarball and starts building in the tmp 
directory. Marvellous. The build succeeds and everybody is happy.

Then, say I want to rebuild a yocto image after having modified a recipe 
(bar). bar is needed by foo, so foo will have to be rebuilt. No problem 
everything is fine. foo is not redownloaded since it's already in 
downloads. there's a do_unpack() and so on.

Here's the problem. A week later, I modify bar again, so foo will need 
to be rebuilt. A bit on the hard drive flipped so the checksum of foo's 
tarball does not match anymore. Apparently and from what I read, 
Bitbake's do_unpack does not verify the checksum as it's only validated 
during do_fetch. Building and installing foo succeeds though as the 
rotten bit only affects runtime. The image is created like no problem 
occured and we install the image. Then there's the crash, we search a 
lot and finally find the issue. A simple -c cleanall foo and the problem 
will disappear.

#
Now, my question : Would it be hard to bitbake's contributors to add a 
checksum validation during the do_unpack step? Hard-drive errors like 
this can occur, and such above-mentionned pain would be so easily 
avoided by a quick checksum...
#

Many thanks.
Lee
P.S.: " If I had more time, I would have written a shorter letter"


--------------070701060800080103060908
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi all,<br>
    [Go to paragraph surrounded by # if in a hurry]<br>
    <br>
    The company I work for is using Yocto (customized version of dylan).
    We recently faced a little problem with bitbake and my google-fu
    seems to be insufficient to solve it.<br>
    <br>
    I know that when SRC_URI of a recipe is changed, the MD5 and SHA
    sums will have to be updated. If not, bitbake will fail with a very
    verbose error telling exactly what are the new checksums so I can
    easily update them in the recipe.<br>
    <br>
    I also know that a tarball of a recipe might change on a server
    without having its version changed. This is a very bad practice but
    when this happen we are dealing with it.<br>
    <br>
    No, the problem we're having is not about these well documented
    cases. The problem is about rotten bits.<br>
    <br>
    You see, we have a recipe (let's call it foo) that need to be build
    from scratch. Bitbake will do_fetch() it, and verify the checksums.
    Everything's fine, the tarball is saved in the yocto's downloads
    folder. Bitbake then do_unpack() the tarball and starts building in
    the tmp directory. Marvellous. The build succeeds and everybody is
    happy. <br>
    <br>
    Then, say I want to rebuild a yocto image after having modified a
    recipe (bar). bar is needed by foo, so foo will have to be rebuilt.
    No problem everything is fine. foo is not redownloaded since it's
    already in downloads. there's a do_unpack() and so on.<br>
    <br>
    Here's the problem. A week later, I modify bar again, so foo will
    need to be rebuilt. A bit on the hard drive flipped so the checksum
    of foo's tarball does not match anymore. Apparently and from what I
    read, Bitbake's do_unpack does not verify the checksum as it's only
    validated during do_fetch. Building and installing foo succeeds
    though as the rotten bit only affects runtime. The image is created
    like no problem occured and we install the image. Then there's the
    crash, we search a lot and finally find the issue. A simple -c
    cleanall foo and the problem will disappear.<br>
    <br>
    #<br>
    Now, my question : Would it be hard to bitbake's contributors to add
    a checksum validation during the do_unpack step? Hard-drive errors
    like this can occur, and such above-mentionned pain would be so
    easily avoided by a quick checksum...<br>
    #<br>
    <br>
    Many thanks.<br>
    Lee<br>
    P.S.: "
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    If I had more time, I would have written a shorter letter"<br>
    <br>
    <div class="moz-signature">
      <div class="moz-signature">
        <div class="moz-signature">
          <div class="moz-signature"> </div>
        </div>
      </div>
    </div>
  </body>
</html>

--------------070701060800080103060908--
