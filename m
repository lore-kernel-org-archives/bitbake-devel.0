Return-Path: <dugaso@Sonatest.com>
Received: from smarthost1.mail.uk.easynet.net (smarthost1.mail.uk.easynet.net
	[212.135.6.11])
	by mail.openembedded.org (Postfix) with ESMTP id 671F4609BF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 17:04:09 +0000 (UTC)
Received: from [217.206.231.74] (port=36942 helo=mail.sonatest.com)
	by smarthost1.mail.uk.easynet.net with esmtp (Exim 4.72)
	(envelope-from <dugaso@Sonatest.com>)
	id 1XW71n-0006P4-Lr; Mon, 22 Sep 2014 18:03:56 +0100
Received: from [192.168.128.68] (192.168.128.68) by EXCHANGE.Sonatest.net
	(212.56.87.3) with Microsoft SMTP Server id 14.2.347.0; Mon, 22 Sep 2014
	18:04:06 +0100
Message-ID: <54205685.2060104@sonatest.com>
Date: Mon, 22 Sep 2014 13:04:05 -0400
From: Olivier Dugas <dugaso@sonatest.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To: "Burton, Ross" <ross.burton@intel.com>
References: <54203B56.5030607@sonatest.com>
	<CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
	<CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
In-Reply-To: <CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
X-Mailshell-score: 40, threshold=98, smtpSenderIP=212.56.87.3
	utc=<2014-09-22 17:04:09>
X-EXCLAIMER-MD-CONFIG: 7c1584ba-e595-4fa0-82b4-f84c142522ec
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Bitbake do_unpack checksum?
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
X-List-Received-Date: Mon, 22 Sep 2014 17:04:10 -0000
Content-Type: multipart/alternative;
	boundary="------------040402060003080202050905"

--------------040402060003080202050905
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ross and thank you for having taken the time,
I agree about the fact that if the disk might suffer from random bit 
flips, I couldn't trust it. In fact, like proposed there 
(https://wiki.yoctoproject.org/wiki/Build_Performance), I optimised the 
build performance knowing that the file system image would be built 
faster at the costs implied, which are (among others) that I could not 
trust the image.

The only thing that gets on a disk that is totally healthy (because we 
need to keep away from bit flips) is the download folder with all the 
tarballs. Still, you know that bit flips can occur, granted that it's 
much less frequent. The problem here is that it's the first time maybe 3 
years that a bit flip occured. So it's not really a problem about disk 
about to fail, but more about random flips caused by say solar wind or 
something!

I personnally would be satisfied by the point made by Richard Purdie in 
bug 5571 (comment 2), that is putting the checksum into the .done file. 
I believe this would indeed avoid errors like the one we got here. Was 
it implemented? If somebody did this, do you know the commit id, so I 
can try to cherry pick it.

Best regards,

*Olivier*

Le 2014-09-22 12:18, Burton, Ross a écrit :
> On 22 September 2014 17:16, Burton, Ross <ross.burton@intel.com> wrote:
>> No, it wouldn't be hard.
>>
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571
> I hit sent a little early then.  5571 is a related issue, but if
> you're a disk which is suffering from random bit flips, then do you
> want to trust it to building a file system image that likely is
> corrupted?  By extension we should checksum every file we generate
> just in case they get corrupted too...
>
> Ross


--------------040402060003080202050905
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Ross and thank you for having taken
      the time,<br>
      I agree about the fact that if the disk might suffer from random
      bit flips, I couldn't trust it. In fact, like proposed there
      (<a class="moz-txt-link-freetext" href="https://wiki.yoctoproject.org/wiki/Build_Performance">https://wiki.yoctoproject.org/wiki/Build_Performance</a>), I
      optimised the build performance knowing that the file system image
      would be built faster at the costs implied, which are (among
      others) that I could not trust the image.<br>
      <br>
      The only thing that gets on a disk that is totally healthy
      (because we need to keep away from bit flips) is the download
      folder with all the tarballs. Still, you know that bit flips can
      occur, granted that it's much less frequent. The problem here is
      that it's the first time maybe 3 years that a bit flip occured. So
      it's not really a problem about disk about to fail, but more about
      random flips caused by say solar wind or something!<br>
      <br>
      I personnally would be satisfied by the point made by Richard
      Purdie in bug 5571 (comment 2), that is putting the checksum into
      the .done file. I believe this would indeed avoid errors like the
      one we got here. Was it implemented? If somebody did this, do you
      know the commit id, so I can try to cherry pick it.<br>
      <br>
      Best regards,<br>
      <div class="moz-signature">
        <meta http-equiv="content-type" content="text/html;
          charset=utf-8">
        <title></title>
        <div class="moz-signature">
          <div class="moz-signature">
            <div class="moz-signature">
              <pre class="moz-signature" cols="72"><font face="Arial"><b>Olivier</b>
</font>
</pre>
            </div>
          </div>
        </div>
      </div>
      Le 2014-09-22 12:18, Burton, Ross a écrit :<br>
    </div>
    <blockquote
cite="mid:CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com"
      type="cite">
      <pre wrap="">On 22 September 2014 17:16, Burton, Ross <a class="moz-txt-link-rfc2396E" href="mailto:ross.burton@intel.com">&lt;ross.burton@intel.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">No, it wouldn't be hard.

<a class="moz-txt-link-freetext" href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571">https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571</a>
</pre>
      </blockquote>
      <pre wrap="">
I hit sent a little early then.  5571 is a related issue, but if
you're a disk which is suffering from random bit flips, then do you
want to trust it to building a file system image that likely is
corrupted?  By extension we should checksum every file we generate
just in case they get corrupted too...

Ross
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040402060003080202050905--
