ENTRY(_start)

PHDRS {
      text PT_LOAD FLAGS((1 << 0) | (1 << 2));
      rodata PT_LOAD FLAGS((1 << 2));
      data PT_LOAD FLAGS((1 << 1) | (1 << 2));
}

SECTIONS {
    . = 0x0000000080000000;

    .text : {
        *(.text .text.*)
    } :text

    . = ALIGN(0x1000);

    .rodata : {
        *(.rodata .rodata.*)
    } :rodata

    . = ALIGN(0x1000);

    .data : {
        *(.data .data.*)
    } :data

    . = ALIGN(0x1000);

    .bss : {
        *(COMMON)
        *(.bss .bss.*)
    } :data

    /DISCARD/ : {
        *(.eh_frame)
        *(.comment)
    }
}
