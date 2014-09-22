Return-Path: <dugaso@Sonatest.com>
Received: from smarthost1.mail.uk.easynet.net (smarthost1.mail.uk.easynet.net
	[212.135.6.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6E04860144
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Sep 2014 19:37:41 +0000 (UTC)
Received: from [217.206.231.74] (port=63544 helo=mail.sonatest.com)
	by smarthost1.mail.uk.easynet.net with esmtp (Exim 4.72)
	(envelope-from <dugaso@Sonatest.com>)
	id 1XW9QO-0005Rh-6f; Mon, 22 Sep 2014 20:37:28 +0100
Received: from [192.168.128.68] (192.168.128.68) by EXCHANGE.Sonatest.net
	(212.56.87.3) with Microsoft SMTP Server id 14.2.347.0; Mon, 22 Sep 2014
	20:37:39 +0100
Message-ID: <54207A81.9070102@sonatest.com>
Date: Mon, 22 Sep 2014 15:37:37 -0400
From: Olivier Dugas <dugaso@sonatest.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To: "Burton, Ross" <ross.burton@intel.com>
References: <54203B56.5030607@sonatest.com>
	<CAJTo0LYScX=1iJDcxy1ff_TBR6ueJOQ-7Twcbdy-kBQsCBfLvQ@mail.gmail.com>
	<CAJTo0LZgRQNZF1_gjOvrMfNCaaServst1FiU9tjrDE5CbHEBKQ@mail.gmail.com>
	<54205685.2060104@sonatest.com>
	<CAJTo0Lbfg7nz7vYLOhT2VuxDCCeO0eBVtmer+ODFQTwfgncTrA@mail.gmail.com>
In-Reply-To: <CAJTo0Lbfg7nz7vYLOhT2VuxDCCeO0eBVtmer+ODFQTwfgncTrA@mail.gmail.com>
X-Mailshell-score: 40, threshold=98, smtpSenderIP=212.56.87.3
	utc=<2014-09-22 19:37:42>
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
X-List-Received-Date: Mon, 22 Sep 2014 19:37:47 -0000
Content-Type: multipart/alternative;
	boundary="------------040802040003050206040304"

--------------040802040003050206040304
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

my bad, you're right. I would need to recompute the checksum at every 
do_unpack().
I know that no journal and high write delay could corrupt my disk. In 
this event I would reformat and rebuild the image, no big deal. What 
seem to me like a big deal though is to have a healthy hard drive that 
will once every 2 year flip a bit randomly on one of my downloaded 
tarball, and not having bitbake verify the checksum just in case.

When I say it this way, I realize having bitbake doing checksum for 
every already downloaded tarball in the system could indeed add 
significant overhead, like said by Richard Purdie, even if I thought 
that a checksum was a fast operation... So I'm stuck. What would be the 
best solution then? I can't see any other simple solution then the one 
you proposed in #5571.

What do you think?

*Olivier*

Le 2014-09-22 15:20, Burton, Ross a écrit :
> On 22 September 2014 18:04, Olivier Dugas <dugaso@sonatest.com> wrote:
>> I personnally would be satisfied by the point made by Richard Purdie in bug
>> 5571 (comment 2), that is putting the checksum into the .done file. I
>> believe this would indeed avoid errors like the one we got here. Was it
>> implemented? If somebody did this, do you know the commit id, so I can try
>> to cherry pick it.
> Comment 2 is designed to solve a different problem and won't catch the
> tarball on disk getting corrupted because it will simply be comparing
> a cached checksum in the .done file with the stated checksum in the
> recipe.
>
> I'm not sure what points in the Builld Performance page mean you
> couldn't trust the resulting image.  There are some tweaks that mean
> data loss in the event of power failure (ie no journal, high write
> delay) but in this situation the corrupted disk can be reformatted as
> it only contains built objects and can be entirely regenerated.
>
> Ross


--------------040802040003050206040304
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">my bad, you're right. I would need to
      recompute the checksum at every do_unpack(). <br>
      I know that no journal and high write delay could corrupt my disk.
      In this event I would reformat and rebuild the image, no big deal.
      What seem to me like a big deal though is to have a healthy hard
      drive that will once every 2 year flip a bit randomly on one of my
      downloaded tarball, and not having bitbake verify the checksum
      just in case.<br>
      <br>
      When I say it this way, I realize having bitbake doing checksum
      for every already downloaded tarball in the system could indeed
      add significant overhead, like said by Richard Purdie, even if I
      thought that a checksum was a fast operation... So I'm stuck. What
      would be the best solution then? I can't see any other simple
      solution then the one you proposed in #5571.<br>
      <br>
      What do you think?<br>
      <br>
      <div class="moz-signature">
        <meta http-equiv="content-type" content="text/html;
          charset=utf-8">
        <title></title>
        <div class="moz-signature">
          <div class="moz-signature">
            <div class="moz-signature">
              <pre class="moz-signature" cols="72"><font face="Arial"><b>Olivier </b>
</font>
</pre>
            </div>
          </div>
        </div>
      </div>
      Le 2014-09-22 15:20, Burton, Ross a écrit :<br>
    </div>
    <blockquote
cite="mid:CAJTo0Lbfg7nz7vYLOhT2VuxDCCeO0eBVtmer+ODFQTwfgncTrA@mail.gmail.com"
      type="cite">
      <pre wrap="">On 22 September 2014 18:04, Olivier Dugas <a class="moz-txt-link-rfc2396E" href="mailto:dugaso@sonatest.com">&lt;dugaso@sonatest.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I personnally would be satisfied by the point made by Richard Purdie in bug
5571 (comment 2), that is putting the checksum into the .done file. I
believe this would indeed avoid errors like the one we got here. Was it
implemented? If somebody did this, do you know the commit id, so I can try
to cherry pick it.
</pre>
      </blockquote>
      <pre wrap="">
Comment 2 is designed to solve a different problem and won't catch the
tarball on disk getting corrupted because it will simply be comparing
a cached checksum in the .done file with the stated checksum in the
recipe.

I'm not sure what points in the Builld Performance page mean you
couldn't trust the resulting image.  There are some tweaks that mean
data loss in the event of power failure (ie no journal, high write
delay) but in this situation the corrupted disk can be reformatted as
it only contains built objects and can be entirely regenerated.

Ross
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040802040003050206040304--
