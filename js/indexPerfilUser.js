   function previewImage(event) {
            const output = document.getElementById('profilePreview');
            output.src = URL.createObjectURL(event.target.files[0]);
            output.onload = () => URL.revokeObjectURL(output.src);
        }
        
      