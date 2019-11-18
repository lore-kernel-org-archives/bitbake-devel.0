Return-Path: <maciej.pijanowski@3mdeb.com>
X-Greylist: delayed 2397 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 18 Nov 2019 20:29:55 UTC
Received: from 14.mo5.mail-out.ovh.net (14.mo5.mail-out.ovh.net
	[188.165.51.82])
	by mail.openembedded.org (Postfix) with ESMTP id 0E00F7ED3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 20:29:55 +0000 (UTC)
Received: from player695.ha.ovh.net (unknown [10.108.42.192])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EFD5A259BE8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Nov 2019 20:12:16 +0100 (CET)
Received: from 3mdeb.com (89-66-81-201.dynamic.chello.pl [89.66.81.201])
	(Authenticated sender: maciej.pijanowski@3mdeb.com)
	by player695.ha.ovh.net (Postfix) with ESMTPSA id 4A2D9C253D18;
	Mon, 18 Nov 2019 19:12:13 +0000 (UTC)
To: Wayne Li <waynli329@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Yocto Project Discussion <yocto@yoctoproject.org>
References: <CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com>
From: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
Message-ID: <6bec080c-c289-c808-3618-19206694468c@3mdeb.com>
Date: Mon, 18 Nov 2019 20:12:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com>
X-Ovh-Tracer-Id: 17082153388085161641
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgesrgdtreertdefjeenucfhrhhomhepofgrtghivghjucfrihhjrghnohifshhkihcuoehmrggtihgvjhdrphhijhgrnhhofihskhhiseefmhguvggsrdgtohhmqeenucffohhmrghinhepfehmuggvsgdrtghomhdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekledrieeirdekuddrvddtudenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrggtihgvjhdrphhijhgrnhhofihskhhiseefmhguvggsrdgtohhmpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-Mailman-Approved-At: Wed, 20 Nov 2019 22:09:15 +0000
Subject: Re: [yocto] KVM kernel modules missing from Yocto kernel
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
X-List-Received-Date: Mon, 18 Nov 2019 20:29:56 -0000
Content-Type: multipart/alternative;
	boundary="------------4D7DAB0A118426900C79DCAA"
Content-Language: en-US

--------------4D7DAB0A118426900C79DCAA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 18.11.2019 19:22, Wayne Li wrote:
> Dear Yocto Developers,
>
> I'm trying to incorporate KVM into a Yocto kernel me and my coworker 
> build for a T4240 RDB (which has a PowerPC CPU).  The problem is, no 
> matter what I do the KVM kernel module (I'm expecting a kvm.ko or any 
> .ko file along those lines) is not present in the image.
>
> First I tried adding the content of the .config file generated when 
> configuring the kernel for KVM support into the kernel configuration 
> file.  This resulted in KVM source directories appearing in the kernel 
> but no KVM related kernel modules are present.  I explain this in more 
> detail in a previous email conversation I had with the Yocto community 
> (saved in a Github gist for readability):
What is your kenel config? Is KVM built-in (y) or built as module (m)?
>
> https://gist.github.com/WayneZhenLi/d5d7a5e8c30e6d4b7cd4541d0c24cab5
>
> Since then I've tried a few things.  First, I added the following 
> lines to the local.conf file (found in build_t4240rdb-64b/conf folder):
>
> MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kernel-modules"
> MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kvm-image-minimal"
I din't know which image you are building. Those variables are tricky, since
they only applies when basing on the packagegroup-core-boot packagegroup.
Please refer to the documentation.
>
> But that didn't seem to work as there weren't any new .ko files in the 
> final image.  Next I tried adding the following lines to the same 
> local.conf file:
>
> CORE_IMAGE_EXTRA_INSTALL += "kernel-modules"
> CORE_IMAGE_EXTRA_INSTALL += "kvm-image-minimal"
>
Why trying to install the image into image? kvm-image-minimal is not a 
package, it is image recipe.
The build can definitely break in this case.
> This time I get an error saying "ERROR: kvm-image-minimal not found in 
> the base feeds (t4240rdb-64b ppc64e6500 powerpc64 noarch any all)".  
> Also if just run a "ERROR: bitbake kvm-image-minimal" to see what's 
> going on with that particular recipe I get an error saying 
> "kernel-module-kvm-intel" not found in the base feeds (t4240rdb-64b 
> ppc64e6500 powerpc64 noarch any all).
>
> Would I have to write recipes for the packages listed in 
> kvm-image-minimal such as kernel-module-kvm-intel or 
> kernel-module-kvm?  Note that I'm not even building the image for 
> intel; I'm building it for PowerPC.  Anyway, I just feel like writing 
> recipes for the KVM kernel modules isn't the correct step.  Like maybe 
> I just messed up my with my configuration somehow?  What are your 
> thoughts?
IMHO: Simply use IMAGE_INSTALL += "kernel-modules" (IMAGE_INSTALL += 
"kernel-module-kvm" will likely install just the KVM module)
in your local.conf to install all built kernel modules. If KVM module 
won't be present in the rootfs, it means it was not built.

Please inspect your kernel work dir (packages-split dir) to find out 
which packages were produced by
the kernel recipe. It will be something like 
build/tmp/work/XX/linux-yocto/XX/packages-split
>
> -Thanks!, Wayne Li
>
>
-- 
Maciej Pijanowski
Embedded Systems Engineer
https://3mdeb.com | @3mdeb_com


--------------4D7DAB0A118426900C79DCAA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 18.11.2019 19:22, Wayne Li wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>Dear Yocto Developers,</div>
        <div><br>
        </div>
        <div>I'm trying to incorporate KVM into a Yocto kernel me and my
          coworker build for a T4240 RDB (which has a PowerPC CPU).  The
          problem is, no matter what I do the KVM kernel module (I'm
          expecting a kvm.ko or any .ko file along those lines) is not
          present in the image.</div>
        <div><br>
        </div>
        <div>First I tried adding the content of the .config file
          generated when configuring the kernel for KVM support into the
          kernel configuration file.  This resulted in KVM source
          directories appearing in the kernel but no KVM related kernel
          modules are present.  I explain this in more detail in a
          previous email conversation I had with the Yocto community
          (saved in a Github gist for readability):</div>
      </div>
    </blockquote>
    What is your kenel config? Is KVM built-in (y) or built as module
    (m)?<br>
    <blockquote type="cite"
cite="mid:CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div><a
href="https://gist.github.com/WayneZhenLi/d5d7a5e8c30e6d4b7cd4541d0c24cab5"
            target="_blank" moz-do-not-send="true">https://gist.github.com/WayneZhenLi/d5d7a5e8c30e6d4b7cd4541d0c24cab5</a></div>
        <div><br>
        </div>
        <div>Since then I've tried a few things.  First, I added the
          following lines to the local.conf file (found in
          build_t4240rdb-64b/conf folder):</div>
        <div><br>
        </div>
        <div>
          MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kernel-modules"<br>
          MACHINE_ESSENTIAL_EXTRA_RRECOMMENDS += "kvm-image-minimal"
          <br>
        </div>
      </div>
    </blockquote>
    I din't know which image you are building. Those variables are
    tricky, since<br>
    they only applies when basing on the packagegroup-core-boot
    packagegroup.<br>
    Please refer to the documentation.<br>
    <blockquote type="cite"
cite="mid:CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>But that didn't seem to work as there weren't any new .ko
          files in the final image.  Next I tried adding the following
          lines to the same local.conf file:</div>
        <div><br>
        </div>
        <div>
          CORE_IMAGE_EXTRA_INSTALL += "kernel-modules"<br>
          CORE_IMAGE_EXTRA_INSTALL += "kvm-image-minimal"</div>
        <div><br>
        </div>
      </div>
    </blockquote>
    Why trying to install the image into image? kvm-image-minimal is not
    a package, it is image recipe.<br>
    The build can definitely break in this case.<br>
    <blockquote type="cite"
cite="mid:CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com">
      <div dir="ltr">
        <div>This time I get an error saying "ERROR: kvm-image-minimal
          not found in the base feeds (t4240rdb-64b ppc64e6500 powerpc64
          noarch any all)".  Also if just run a "ERROR: bitbake
          kvm-image-minimal" to see what's going on with that particular
          recipe I get an error saying "kernel-module-kvm-intel" not
          found in the base feeds (t4240rdb-64b ppc64e6500 powerpc64
          noarch any all).</div>
        <div><br>
        </div>
        <div>Would I have to write recipes for the packages listed in
          kvm-image-minimal such as kernel-module-kvm-intel or
          kernel-module-kvm?  Note that I'm not even building the image
          for intel; I'm building it for PowerPC.  Anyway, I just feel
          like writing recipes for the KVM kernel modules isn't the
          correct step.  Like maybe I just messed up my with my
          configuration somehow?  What are your thoughts?</div>
      </div>
    </blockquote>
    IMHO: Simply use IMAGE_INSTALL += "kernel-modules" (IMAGE_INSTALL +=
    "kernel-module-kvm" will likely install just the KVM module)<br>
    in your local.conf to install all built kernel modules. If KVM
    module won't be present in the rootfs, it means it was not built.<br>
    <br>
    Please inspect your kernel work dir (packages-split dir) to find out
    which packages were produced by<br>
    the kernel recipe. It will be something like
    build/tmp/work/XX/linux-yocto/XX/packages-split<br>
    <blockquote type="cite"
cite="mid:CAM2K0nrK_LycaTR4N87+3j_LyWtKcSq4fLC5Ramq_MpvGsr1Fg@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>-Thanks!, Wayne Li<br>
        </div>
        <div><br>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
    </blockquote>
    <pre class="moz-signature" cols="72">-- 
Maciej Pijanowski
Embedded Systems Engineer
<a class="moz-txt-link-freetext" href="https://3mdeb.com">https://3mdeb.com</a> | @3mdeb_com</pre>
  </body>
</html>

--------------4D7DAB0A118426900C79DCAA--
