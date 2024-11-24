<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateOrderRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'rug_id' => 'required',
            'client_id' => 'required',
            'size_id' => 'required',
            'status' => 'required',
            'total_price' => 'required|numeric',
            'color_palet' => 'required|array',
            'image' => 'nullable|image',
            'delivery_date' => 'nullable|date',
            'description' => 'nullable|string',
        ];
    }
}
